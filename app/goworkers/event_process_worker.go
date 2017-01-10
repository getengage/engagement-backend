// Downsample raw events sent from client to API endpoint

package main

import (
    "os"
    "fmt"
    "github.com/jrallison/go-workers"
    "github.com/sajari/regression"
    "github.com/ip2location/ip2location-go"
    "encoding/json"
    "crypto/rand"
    "encoding/base32"
    "math"
    "./models"
)

const (
    initialDelay = 2.0
    avgReadingSpeed = 270.0
    intervalInSeconds = 2.0 // time elapsed between each metrics
)

func getUUID(length int) string {
    randomBytes := make([]byte, 32)
    _, err := rand.Read(randomBytes)
    if err != nil {
        panic(err)
    }
    return base32.StdEncoding.EncodeToString(randomBytes)[:length]
}

func processEvent(e models.EventsRaw) (processed map[string]interface{}) {
    uuid := getUUID(10)
    final_score := 0.0
    r := new(regression.Regression)
    r.SetObserved("Y Position")
    r.SetVar(1, "Y Pos")

    for i := 0; i < e.Count; i++ {
        if (e.YPositions()[i] >= e.Bottom && e.ReachedEnd != true) {
          e.ReachedEnd = true
        }

        if (e.Visible()[i] == true && e.Viewport()[i] == true) {
          e.InViewportAndVisible++
        }

        elapsed := float64(i) + 1.0
        dp := regression.DataPoint(e.YPositions()[i], []float64{elapsed * intervalInSeconds})
        r.Train(dp)
    }

    r.Run()

    // gauge viewport time for user w/ avg reading speed
    estimated_in_viewport_threshold := ((e.WordCount / avgReadingSpeed) * 60.0)
    // total viewport time accounting for 2 second delay/gap and startup delay
    total_in_viewport_time := e.InViewportAndVisible * intervalInSeconds + initialDelay
    estimated_total_read_through := total_in_viewport_time / estimated_in_viewport_threshold
    rsquared_calculation := r.R2

    // Regression Strength - max 50 points
    if math.IsNaN(rsquared_calculation) {
        final_score += 10.0
    } else {
        final_score += math.Min(rsquared_calculation * 50.0, 50.0)
    }

    // InViewPort Time - max 100 Points
    final_score += math.Min(estimated_total_read_through * 100.0, 100.0)

    processed = map[string]interface{}{
        "source_url": e.SourceURL,
        "api_key": e.APIKeyID,
        "uuid": uuid,
        "session_id": e.SessionID,
        "referrer": e.Referrer,
        "reached_end_of_content": e.ReachedEnd,
        "total_in_viewport_time": e.InViewportAndVisible,
        "word_count": e.WordCount,
        "score": final_score,
        "city": e.IP2.City,
        "region": e.IP2.Region,
        "country": e.IP2.Country_long,
        "remote_ip": e.RemoteIP,
    }

    return
}

func buildEventsCollection(message *workers.Msg) (collection []models.EventsRaw) {
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
      workers.Enqueue("default", "Event::EventProcessInsert", []string{"test"})
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
