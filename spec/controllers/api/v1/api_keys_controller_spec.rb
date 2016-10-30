require "rails_helper"

RSpec.describe Api::V1::ApiKeysController, type: :controller do
  let(:user) { create(:user) }

  describe '#create' do
    describe "with valid params" do
      it "creates a new ApiKey" do
        expect {
          post :create, { user_id: user.id, name: "FooBar" }
        }.to change(ApiKey, :count).by(1)
      end

      it "responds with json" do
        post :create, { user_id: user.id, name: "FooBar" }
        expect response.content_type == "application/json"
      end
    end

    describe "with invalid params" do
      it "raises error w/ missing name" do
        expect {
          post :create, { user_id: user.id, huh: "wah" }
        }.to raise_error ActionController::ParameterMissing

        expect {
          post :create, { user_id: user.id, name: "" }
        }.to raise_error ActionController::ParameterMissing
      end

      it "raises error w/ missing user_id" do
        expect {
          post :create, { name: "FooBar" }
        }.to raise_error ActionController::ParameterMissing

        expect {
          post :create, { user_id: "", name: "FooBar" }
        }.to raise_error ActionController::ParameterMissing
      end
    end
  end

  describe '#destroy' do
    describe "with valid params" do
      it "sets the expired_at time" do
      end

      it "is idempotent" do
      end
    end
  end
end