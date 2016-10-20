// Downsample raw events sent from client to API endpoint

package main

import (
    "fmt"
    "github.com/jrallison/go-workers"
    "github.com/sajari/regression"
    "github.com/influxdata/influxdb/client/v2"
    "github.com/influxdata/influxdb/uuid"
    "github.com/ip2location/ip2location-go"
    "time"
    "encoding/json"
    "math"
    "os"
)

const (
    MyDB = "engagement_development"
    username = "root"
    password = "root"
    avgReadingSpeed = 270.0
)

func keyIndex(collection []string, match string) int {
    for i := 0; i < len(collection); i++ {
        if (collection[i] == match) {
            return i
        }
    }
    return -1
}

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
    // get current working directory and IP/country Lookup
    pwd, _ := os.Getwd()
    ip2location.Open(pwd + "/lib/ip2location/IP2LOCATION-LITE-DB3.BIN")

    // create new Influx client
    clnt, _ := client.NewHTTPClient(client.HTTPConfig{
        Addr: "http://localhost:8086",
    })

    q := fmt.Sprintf("SELECT * FROM %s where time > now() - 1d group by source_url, session_id", "events")
    res, _ := queryDB(clnt, q)

    bp, _ := client.NewBatchPoints(client.BatchPointsConfig{
        Database:  MyDB,
        Precision: "s",
    })

    for _, response_row := range res {
      for _, results_row := range response_row.Series {

        // initial setup of score & time layout
        final_score := 0.0
        time_layout := time.RFC3339

        // measurement key indexes
        apiKeyIdx := keyIndex(results_row.Columns, "api_key")
        wordCountIdx := keyIndex(results_row.Columns, "word_count")
        referrerIdx := keyIndex(results_row.Columns, "referrer")
        yPosIdx := keyIndex(results_row.Columns, "y_pos")
        bottomIdx := keyIndex(results_row.Columns, "bottom")
        remoteIpIdx := keyIndex(results_row.Columns, "remote_ip")

        // regression calculation setup

        r := new(regression.Regression)
        r.SetObserved("Scroll Depth")
        r.SetVar(0, "Elapsed Time")
        r.SetVar(1, "Is Visible")

        // time in viewport calculation and end of content check
        in_viewport_and_visible := 0.0
        reached_end_of_content := false

        // estimated reading time
        word_count, _ := results_row.Values[0][wordCountIdx].(json.Number).Float64()
        referrer := results_row.Values[0][referrerIdx].(string)

        // iterate over values for a given series
        for _, data_row := range results_row.Values {
          if data_row[3] == true && data_row[4] == true {
            in_viewport_and_visible++
          }

          parsed_time, _ := time.Parse(time_layout, data_row[0].(string))
          starting_time, _ := time.Parse(time_layout, results_row.Values[0][0].(string))
          elapsed_time_in_seconds := parsed_time.Sub(starting_time).Seconds()
          y_position, _ := data_row[yPosIdx].(json.Number).Float64()
          bottom_of_viewport, _ := data_row[bottomIdx].(json.Number).Float64()
          if (y_position > bottom_of_viewport && reached_end_of_content != true) {
            reached_end_of_content = true
            _ = reached_end_of_content
          }
          dp := regression.DataPoint(y_position, []float64{elapsed_time_in_seconds, 1})
          r.Train(dp)
        }

        // lookup location from remote_ip
        ip2location_results := ip2location.Get_all(results_row.Values[0][remoteIpIdx].(string))
        country := ip2location_results.Country_long
        region := ip2location_results.Region
        city := ip2location_results.City

        // total viewport time accounting for 2 second delay/gap
        total_in_viewport_time := in_viewport_and_visible * 2

        // gauge viewport time for user w/ avg reading speed
        estimated_in_viewport_threshold := ((word_count / avgReadingSpeed) * 60.0)

        // run regression
        r.Run()
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

        // for Batching Points
        tags := map[string]string{
            "uuid": uuid.TimeUUID().String(),
            "source_url": results_row.Tags["source_url"],
            "api_key": results_row.Values[0][apiKeyIdx].(string),
        }

        fields := map[string]interface{}{
            "session_id": results_row.Tags["session_id"],
            "referrer": referrer,
            "reached_end_of_content": reached_end_of_content,
            "total_in_viewport_time": total_in_viewport_time,
            "word_count": word_count,
            "score": final_score,
            "city": city,
            "region": region,
            "country": country,
            "remote_ip": results_row.Values[0][remoteIpIdx].(string),
        }

        pt, err := client.NewPoint(
            "event_scores",
            tags,
            fields,
            time.Now(),
        )

        if err != nil {
            fmt.Println(err)
        }

        bp.AddPoint(pt)
      }
    }
    ip2location.Close()
    clnt.Write(bp)
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
  workers.Process("go_queue", RegressionWorker, 20)

  // stats will be available at http://localhost:8080/stats
  go workers.StatsServer(8080)

  // Blocks until process is told to exit via unix signal
  workers.Run()
}
