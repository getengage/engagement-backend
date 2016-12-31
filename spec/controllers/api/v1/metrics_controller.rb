require "rails_helper"

RSpec.describe Api::V1::MetricsController, type: :controller do
  describe '#create' do
    describe "with valid params" do
      it "creates a new EventsRaw" do
        expect {
          post :create, { data: attributes_for(:events_raw) }
        }.to change(Event::EventsRaw, :count).by(1)
      end
    end
  end
end
