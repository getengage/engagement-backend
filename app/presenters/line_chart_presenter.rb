class LineChartPresenter
  include ActionView::Helpers
  attr_reader :data, :options

  def initialize(titles:, labels:, data:, **options)
    @options = default_options.reverse_merge(options)
    @data = {
      labels: labels,
      datasets: mapped_datasets(titles, data)
    }
  end

  def mapped_datasets(titles, datasets)
    datasets.map do |data|
      color = cycled_colors
      {
          tension: 0,
          label: titles.shift,
          backgroundColor: color,
          borderColor: color,
          data: data
      }
    end
  end

  def cycled_colors
    cycle(
      "rgba(52, 152, 219, 0.5)",
      "rgba(41, 128, 185, 0.5)"
    )
  end

  def default_options
    {
      height: "80",
      legend: { display: false },
      scales: {
        xAxes: [
          gridLines: {
            display: false
          }
        ],
        yAxes: [
          display: false
        ]
      }
    }
  end
end
