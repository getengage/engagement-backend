module Api::V1
  class ApiKeysController < ApiController
    def create
      user = User.find(params.require(:user_id))
      new_api_key = ApiKey.create(name: params.require(:name))
      user.client.api_keys << new_api_key.reload
      render({json: {uuid: new_api_key.uuid, name: new_api_key.name}})
    end
  end
end