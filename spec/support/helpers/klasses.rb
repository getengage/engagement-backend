class CompatObj
  attr_accessor :foo

  def initialize(foo)
    @foo = foo
  end

  def as_json
    {"json_class": self.class.to_s, foo: @foo}
  end
end
