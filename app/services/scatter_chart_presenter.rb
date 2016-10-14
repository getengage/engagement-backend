class ScatterChartPresenter
  attr_reader :data, :options

  def initialize(title:, labels:, data:, **options)
    @options = default_options.reverse_merge(options)
    @data = {
      labels: labels,
      datasets: [
        {
            label: title,
            backgroundColor: "rgba(220,220,220,0.2)",
            borderColor: "rgba(220,220,220,1)",
            data: data.values.map{|x| {x: x.score, y: x.total_in_viewport_time} },
            radius: 25,
            pointBorderColor: "rgba(75,192,192,1)",
            pointBackgroundColor: "rgba(178, 235, 242, 1)",
            pointHoverRadius: 25,
            scaleSteps: 10
        }
      ]
    }
  end

  def default_options
    { height: "200",
      legend: { position: "bottom" },
      scales: {
        yAxes: [{
          display: true,
          ticks: {
            beginAtZero: true,
            steps: 10
          }
        }]
      }
    }
  end
end
