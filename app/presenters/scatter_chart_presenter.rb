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
            data: data.map{|x| {x: x.score, y: x.total_in_viewport_time} },
            radius: 25,
            pointBorderColor: "rgba(75,192,192,1)",
            pointBackgroundColor: "rgba(224, 247, 250, 1)",
            pointHoverRadius: 25
        }
      ]
    }
  end

  def default_options
    { height: "400",
      maintainAspectRatio: false,
      showLines: false,
      legend: { position: "bottom" },
      scales: {
        xAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  end
end
