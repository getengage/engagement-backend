module Event
  class ActivityCollection < Hashie::Trash
    include Hashie::Extensions::Coercion
    property "name"
    property "tags"
    property :activities, from: "values"
    coerce_key :values, Array[ActivityObject]
  end
end
