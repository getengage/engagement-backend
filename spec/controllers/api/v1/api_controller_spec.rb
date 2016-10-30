require "rails_helper"
require "support/helpers/klasses"

RSpec.describe Api::V1::ApiController, type: :controller do
  it "is an abstract, base class" do
    expect(described_class.abstract).to be_truthy
  end

  controller do
    def create
      render({json: CompatObj.new("bar")})
    end
  end

  describe "#render" do
    it "returns w/ correct response" do
      json = Oj.dump(CompatObj.new("bar"), mode: :compat)
      post :create
      expect(response).to have_http_status :ok
      expect(response.body).to eq json
      expect(response.content_type).to eq "application/json"
      expect(response.content_length).to eq json.bytesize
    end
  end
end