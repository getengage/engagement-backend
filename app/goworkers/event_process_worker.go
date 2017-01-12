// Downsample raw events sent from client to API endpoint

package main

import (
    "fmt"
    "github.com/jrallison/go-workers"
    "github.com/sajari/regression"
    "encoding/json"
    "math"
    "./models"
)

const (
    initialDelay = 2.0
    avgReadingSpeed = 270.0
    intervalInSeconds = 2.0 // time elapsed between each metrics
)

func processEvent(e models.EventsRaw) (processed map[string]interface{}) {
    final_score := 0.0
    r := new(regression.Regression)
    r.SetObserved("Y Position")
    r.SetVar(1, "Y Pos")

    for i := 0; i < e.Count; i++ {
        currentYPos := e.YPositions()[i]
        e.CheckScroll(currentYPos)

        if (currentYPos >= e.Bottom && e.ReachedEnd != true) {
          e.ReachedEnd = true
        }

        if (e.Visible()[i] == true && e.Viewport()[i] == true) {
          e.InViewportAndVisible++
        }

        elapsed := float64(i) + 1.0
        dp := regression.DataPoint(currentYPos, []float64{elapsed * intervalInSeconds})
        r.Train(dp)
    }

    r.Run()

    if e.ReachedEnd {
      final_score += 25.0
    }

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
        "api_key_id": e.APIKeyID,
        "session_id": e.SessionID,
        "referrer": e.Referrer,
        "reached_end_of_content": e.ReachedEnd,
        "total_in_viewport_time": e.InViewportAndVisible,
        "word_count": e.WordCount,
        "final_score": final_score,
        "city": e.IP2.City,
        "region": e.IP2.Region,
        "country": e.IP2.Country_long,
        "remote_ip": e.RemoteIP,
        "q1_time": e.Scroll.Q1,
        "q2_time": e.Scroll.Q2,
        "q3_time": e.Scroll.Q3,
        "q4_time": e.Scroll.Q4,
    }

    return
}

func buildEventsCollection(message *workers.Msg) (collection []models.EventsRaw) {
    json.Unmarshal([]byte(message.Args().ToJson()), &collection)
    return
}

func EventProcessWorker(message *workers.Msg) {
    collection := buildEventsCollection(message)
    processed_events := make([]string,len(collection))

    for i := 0; i < len(collection); i++ {
      collection[i].SetIP2()
      processedEvent := processEvent(collection[i])
      encoded_event, _ := json.Marshal(processedEvent)
      processed_events[i] = string(encoded_event)
    }

    fmt.Println(processed_events)
    encoded_payload, _ := json.Marshal(processed_events)
    workers.Enqueue("default", "Event::EventProcessInsert", string(encoded_payload))
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
