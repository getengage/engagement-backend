package main

import (
    "fmt"
    "github.com/jrallison/go-workers"
    "github.com/sajari/regression"
    "github.com/influxdata/influxdb/client/v2"
    "time"
    "encoding/json"
)

const (
    MyDB = "engagement_development"
    username = "root"
    password = "root"
)

// queryDB convenience function to query the database
func queryDB(clnt client.Client, cmd string) (res []client.Result, err error) {
    q := client.Query{
        Command:  cmd,
        Database: MyDB,
    }
    if response, err := clnt.Query(q); err == nil {
        if response.Error() != nil {
            return res, response.Error()
        }
        res = response.Results
    } else {
        return res, err
    }
    return res, nil
}

func RegressionWorker(message *workers.Msg) {
    clnt, _ := client.NewHTTPClient(client.HTTPConfig{
        Addr: "http://localhost:8086",
    })
    q := fmt.Sprintf("SELECT * FROM %s group by source_url, session_id", "events")
    res, _ := queryDB(clnt, q)

    for _, response_row := range res {
      for _, results_row := range response_row.Series {
        final_scores := make([]float64, 2)
        time_layout := time.RFC3339

        // regression calculation

        r := new(regression.Regression)
        r.SetObserved("Scroll Depth")
        r.SetVar(0, "Elapsed Time")
        r.SetVar(1, "Is Visible")

        // time in viewport calculation
        in_viewport := 0

        // estimated reading time
        word_count, _ := results_row.Values[0][7].(json.Number).Float64()

        for _, data_row := range results_row.Values {
          if data_row[3] == true && data_row[4] == true {
            in_viewport++
          }
          parsed_time, _ := time.Parse(time_layout, data_row[0].(string))
          starting_time, _ := time.Parse(time_layout, results_row.Values[0][0].(string))
          elapsed_time_in_seconds := parsed_time.Sub(starting_time).Seconds()
          float, _ := data_row[8].(json.Number).Float64()
          dp := regression.DataPoint(float, []float64{elapsed_time_in_seconds, 1})
          r.Train(dp)
        }

        r.Run()
        final_scores = append(final_scores, r.R2 * 1000.0)
        final_scores = append(final_scores, (word_count / 270) * 60)
        fmt.Printf("%s\n", final_scores)
      }
    }
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

  // pull messages from "myqueue2" with concurrency of 20
  workers.Process("go_queue", RegressionWorker, 20)

  // stats will be available at http://localhost:8080/stats
  go workers.StatsServer(8080)

  // Blocks until process is told to exit via unix signal
  workers.Run()
}
