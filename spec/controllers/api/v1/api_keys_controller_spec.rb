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
    let(:api_key) { create(:api_key, client: user.client) }

    describe "with valid params" do
      it "soft deletes api key" do
        expect {
          delete :destroy, { user_id: user.id, uuid: api_key.uuid }
        }.to change(ApiKey.unscoped, :count).by(1)
      end

      it "sets expired_at column" do
        time = Date.current
        Timecop.freeze(time) do
          delete :destroy, { user_id: user.id, uuid: api_key.uuid }
          expect(api_key.reload.expired_at).to eq time
        end
      end
    end

    describe "with invalid params" do
      it "raises error w/ invalid uuid" do
        expect {
          delete :destroy, { user_id: user.id, uuid: SecureRandom.hex }
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
