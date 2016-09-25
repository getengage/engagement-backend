module Api::V1
  class ApiKeysController < ApiController
    def create
      user = User.find(params.require(:user_id))
      user.client.api_keys << ApiKey.create(name: params.require(:name))
    end
  end
end