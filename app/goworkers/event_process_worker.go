package main

import (
	"encoding/json"
	"fmt"
	"math"

	"./models"
	"github.com/jrallison/go-workers"
	"github.com/sajari/regression"
)

const (
	initialDelay      = 2.0
	avgReadingSpeed   = 270.0
	intervalInSeconds = 2.0 // time elapsed between each metrics
)

func processEvent(e models.EventsRaw) (processed map[string]interface{}) {
	finalScore := 0.0
	r := new(regression.Regression)
	r.SetObserved("Y Position")
	r.SetVar(1, "Y Pos")

	for i := 0; i < e.Count; i++ {
		currentYPos := e.YPositions()[i]
		e.CheckScroll(currentYPos)

		if currentYPos >= e.Bottom && e.ReachedEnd != true {
			e.ReachedEnd = true
		}

		if e.Visible()[i] == true && e.Viewport()[i] == true {
			e.InViewportAndVisible++
		}

		elapsed := float64(i) + 1.0
		dp := regression.DataPoint(currentYPos, []float64{elapsed * intervalInSeconds})
		r.Train(dp)
	}

	r.Run()

	if e.ReachedEnd {
		finalScore += 25.0
	}

	// gauge viewport time for user w/ avg reading speed
	estimatedInViewportThreshold := ((e.WordCount / avgReadingSpeed) * 60.0)
	// total viewport time accounting for 2 second delay/gap and startup delay
	totalViewportTime := e.InViewportAndVisible*intervalInSeconds + initialDelay
	estimatedReadThrough := totalViewportTime / estimatedInViewportThreshold
	rSquared := r.R2

	// Regression Strength - max 50 points
	if math.IsNaN(rSquared) {
		finalScore += 10.0
	} else {
		finalScore += math.Min(rSquared*50.0, 50.0)
	}

	// InViewPort Time - max 100 Points
	finalScore += math.Min(estimatedReadThrough*100.0, 100.0)

	processed = map[string]interface{}{
		"timestamp":              e.Timestamp,
		"source_url":             e.SourceURL,
		"api_key_id":             e.APIKeyID,
		"session_id":             e.SessionID,
		"referrer":               e.Referrer,
		"reached_end_of_content": e.ReachedEnd,
		"total_in_viewport_time": e.InViewportAndVisible,
		"word_count":             e.WordCount,
		"final_score":            finalScore,
		"city":                   e.IP2.City,
		"region":                 e.IP2.Region,
		"country":                e.IP2.Country_long,
		"remote_ip":              e.RemoteIP,
		"user_agent":             e.UserAgent,
		"q1_time":                e.Scroll.Q1,
		"q2_time":                e.Scroll.Q2,
		"q3_time":                e.Scroll.Q3,
		"q4_time":                e.Scroll.Q4,
		"tags":                   e.Tags,
	}

	return
}

func buildEventsCollection(message *workers.Msg) (collection []models.EventsRaw) {
	json.Unmarshal([]byte(message.Args().ToJson()), &collection)
	return
}

// EventProcessWorker -- Normalize EventsRaw table records
func EventProcessWorker(message *workers.Msg) {
	collection := buildEventsCollection(message)
	processedEvents := make([]string, len(collection))

	for i := 0; i < len(collection); i++ {
		collection[i].SetIP2()
		event := processEvent(collection[i])
		encodedEvent, _ := json.Marshal(event)
		processedEvents[i] = string(encodedEvent)
	}

	fmt.Println(processedEvents)
	encodedPayload, _ := json.Marshal(processedEvents)
	workers.Enqueue("default", "Event::EventProcessInsert", string(encodedPayload))
}

func main() {
	workers.Configure(map[string]string{
		"server":   "localhost:6379",
		"database": "0",
		"pool":     "30",
		"process":  "1",
	})
	workers.Process("go_queue", EventProcessWorker, 20)
	go workers.StatsServer(8080)
	workers.Run()
}
