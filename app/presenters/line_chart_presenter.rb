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
      {
          tension: 0,
          label: titles.shift,
          backgroundColor: cycled_colors,
          borderColor: cycled_colors,
          data: data
      }
    end
  end

  def cycled_colors
    cycle(
      "rgba(243, 156, 18,0.3)",
      "rgba(241, 196, 15,0.3)"
    )
  end

  def default_options
    {
      bands: {
        yValue: 100,
        bandLine: {
            stroke: 1.0,
            colour: 'rgba(0, 0, 0, 1.0)',
            type: 'solid',
            label: 'Medium',
            fontSize: '12',
            fontFamily: 'Helvetica, Arial, sans-serif',
            fontStyle: 'normal'
        },
        belowThresholdColour: [
          "rgba(243, 156, 18,0.3)",
          "rgba(243, 156, 18,0.3)"
        ]
      },
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
