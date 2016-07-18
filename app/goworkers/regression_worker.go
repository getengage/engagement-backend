package main

import (
    "fmt"
    "github.com/jrallison/go-workers"
    // "github.com/sajari/regression"
    "github.com/d4l3k/go-pry/pry"
    "github.com/influxdata/influxdb/client/v2"
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
    clnt, err := client.NewHTTPClient(client.HTTPConfig{
        Addr: "http://localhost:8086",
    })
    if err != nil {
        fmt.Printf("error:", err)
    }
    q := fmt.Sprintf("SELECT * FROM %s", "engagement_development")
    res, err := queryDB(clnt, q)
    if err != nil {
        fmt.Printf("error", err)
    }

    fmt.Printf("response:\n", res)

    // do something with your message
    // message.Jid()
    // message.Args() is a wrapper around go-simplejson (http://godoc.org/github.com/bitly/go-simplejson)
    // r := new(regression.Regression)
    // r.SetObserved("Murders per annum per 1,000,000 inhabitants")
    // r.SetVar(0, "Inhabitants")
    // r.SetVar(1, "Percent with incomes below $5000")
    // r.Train(
    //     regression.DataPoint(200, []float64{2000, 1}),
    //     regression.DataPoint(400, []float64{4000, 0}),
    //     regression.DataPoint(600, []float64{6000, 0}),
    //     regression.DataPoint(4000, []float64{8000, 1}),
    //     regression.DataPoint(1000, []float64{10000, 1}),
    //     regression.DataPoint(1200, []float64{12000, 1}))
    // r.Run()
    //
    // fmt.Printf("Regression formula:\n%v\n", r.Formula)
    // fmt.Printf("Regression:\n%s\n", r)
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
