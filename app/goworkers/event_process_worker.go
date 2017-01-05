// Downsample raw events sent from client to API endpoint

package main

import (
    "fmt"
    "github.com/jrallison/go-workers"
    _ "github.com/sajari/regression"
    _ "github.com/ip2location/ip2location-go"
    _ "time"
)

func EventProcessWorker(message *workers.Msg) {
  fmt.Println(message)
  workers.Enqueue("go_queue_b", "EventProcessInsert", []string{id, solvedPuzzle})
}

func main() {
  workers.Configure(map[string]string{
    // location of redis instance
    "server":  "localhost:6379",
    // instance of the database
    "database":  "0",
    // number of connections to keep open with redis
    "pool":    "30",
    // unique process id for this instance of workers (for proper recovery of inprogress jobs on crash)
    "process": "1",
  })

  // pull messages from "go_queue" with concurrency of 20
  workers.Process("go_queue", EventProcessWorker, 20)

  // stats will be available at http://localhost:8080/stats
  go workers.StatsServer(8080)

  // Blocks until process is told to exit via unix signal
  workers.Run()
}
