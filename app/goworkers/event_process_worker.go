// Downsample raw events sent from client to API endpoint

package main

import (
    "os"
    "fmt"
    "github.com/jrallison/go-workers"
    "github.com/sajari/regression"
    "github.com/ip2location/ip2location-go"
    "encoding/json"
)

const (
    intervalInSeconds = 2.0 // time elapsed between each metrics
)

type EventsRaw struct {
    APIKeyID string `json:"api_key_id"`
    Bottom float64 `json:"bottom,string"`
    Count int `json:"count,string"`
    CreatedAt string `json:"created_at"`
    ID string `json:"id"`
    InViewport bool `json:"in_viewport"`
    InViewportArr string `json:"in_viewport_arr"`
    IsVisible bool `json:"is_visible"`
    IsVisibleArr string `json:"is_visible_arr"`
    Referrer string `json:"referrer"`
    RemoteIP string `json:"remote_ip"`
    SessionID string `json:"session_id"`
    SourceURL string `json:"source_url"`
    Timestamp string `json:"timestamp"`
    Top float64 `json:"top,string"`
    UserAgent string `json:"user_agent"`
    WordCount int `json:"word_count,string"`
    XPos float64 `json:"x_pos,string"`
    XPosArr string `json:"x_pos_arr"`
    YPos float64 `json:"y_pos,string"`
    YPosArr string `json:"y_pos_arr"`
    CoordinateMap struct {
        q1 float64  // top quadrant
        q2 float64
        q3 float64
        q4 float64  // bottom quadrant
    }
    reachedEnd bool
    inViewportAndVisible float64
    IP2 ip2location.IP2Locationrecord
}

func (e *EventsRaw) SetIP2() {
    e.IP2 = ip2location.Get_all(e.RemoteIP)
}

func (e *EventsRaw) XPositions() (xs []float64) {
    json.Unmarshal([]byte(e.XPosArr), &xs)
    return
}

func (e *EventsRaw) YPositions() (xy []float64) {
    json.Unmarshal([]byte(e.YPosArr), &xy)
    return
}

func (e *EventsRaw) Visible() (v []bool) {
    json.Unmarshal([]byte(e.IsVisibleArr), &v)
    return
}

func (e *EventsRaw) Viewport() (v []bool) {
    json.Unmarshal([]byte(e.InViewportArr), &v)
    return
}

func processEvent(e EventsRaw) (processed map[string]interface{}) {
    r := new(regression.Regression)
    r.SetObserved("Y Position")
    r.SetVar(1, "Y Pos")

    for i := 0; i < e.Count; i++ {
        if (e.YPositions()[i] >= e.Bottom && e.reachedEnd != true) {
          e.reachedEnd = true
        }

        if (e.Visible()[i] == true && e.Viewport()[i] == true) {
          e.inViewportAndVisible++
        }

        elapsed := float64(i) + 1.0
        dp := regression.DataPoint(e.YPositions()[i], []float64{elapsed * intervalInSeconds})
        r.Train(dp)
    }

    r.Run()

    fmt.Println(r.R2)

    return
}

func buildEventsCollection(message *workers.Msg) (collection []EventsRaw) {
    json.Unmarshal([]byte(message.Args().ToJson()), &collection)
    return
}

func EventProcessWorker(message *workers.Msg) {
    pwd, _ := os.Getwd()
    ip2location.Open(pwd + "/lib/ip2location/IP2LOCATION-LITE-DB3.BIN")

    collection := buildEventsCollection(message)

    for i := 0; i < len(collection); i++ {
      collection[i].SetIP2()
      processedEvent := processEvent(collection[i])
      fmt.Println(processedEvent)
    }
}

func main() {
    workers.Configure(map[string]string{
      "server":  "localhost:6379",
      "database":  "0",
      "pool":    "30",
      "process": "1",
    })
    workers.Process("go_queue", EventProcessWorker, 20)
    go workers.StatsServer(8080)
    workers.Run()
}
