module Event
  class InfluxCollection
    extend InfluxQuery
    attr_accessor :name, :tags
  end
end
