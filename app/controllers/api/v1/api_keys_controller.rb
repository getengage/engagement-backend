module Api::V1
  class ApiKeysController < ApiController
    before_action :get_user

    def create
      new_api_key = ApiKey.create(name: params.require(:name))
      @user.client.api_keys << new_api_key.reload
      render({json: {uuid: new_api_key.uuid, name: new_api_key.name}})
    end

    def destroy
      api_key = @user.api_keys.find_by(uuid: params.require(:uuid))
      api_key.destroy
      render({json: {uuid: api_key.uuid, name: api_key.name}})
    end

    protected
    def get_user
      @user = User.find(params.require(:user_id))
    end
  end
end