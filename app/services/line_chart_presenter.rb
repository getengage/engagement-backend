class LineChartPresenter
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
            data: data
        }
      ]
    }
  end

  def default_options
    { height: "200" }
  end
end