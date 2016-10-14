class BarChartPresenter
  attr_reader :data, :options

  def initialize(title, data, **options)
    @options = default_options.reverse_merge(options)
    @data = {
      labels: padded(data, "N/A", "source_url"),
      datasets: [
        {
            label: title,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
            ],
            borderWidth: 1,
            data: padded(data, 0, "count")
        }
      ]
    }
  end

  def padded(data, filler, method)
    data = data.values.map{|x| x.send(method) }
    data.size == 5 ? data : data + ([filler] * (5 - data.size))
  end

  def default_options
    { height: "200",
      legend: { position: "bottom" },
      tooltips: {
        titleFontSize: 10
      },
      scales: {
        xAxes: [{
          display: false,
        }]
      }
    }
  end
end