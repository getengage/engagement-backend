module Event
  class InfluxCollection < Hashie::Trash
    include Hashie::Extensions::Coercion
    property "name"
    property "tags"
    property "values"
    coerce_key :values, Array[OpenStruct]
  end
end
