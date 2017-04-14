require "rails_helper"

RSpec.describe Api::V1::MetricsController, type: :controller do
  let(:events_raw) {
    attrs = attributes_for(:events_raw)
    attrs[:api_key_id] = attributes_for(:api_key)[:uuid]
    attrs
  }

  describe '#create' do
    describe "with valid params" do
      it "creates a new EventsRaw" do
        post :create, { data: events_raw }
        expect(response.status).to eq(200)
      end
    end
  end
end
