module Api::V1
  class ApiKeysController < ApiController
    before_action :get_user

    def create
      new_api_key = ApiKey.create(name: params.require(:name))
      @user.client.api_keys << new_api_key.reload
      render({json: new_api_key})
    end

    def destroy
      api_key = @user.api_keys.find_by!(uuid: params.require(:uuid))
      render({json: api_key.destroy})
    end

    protected
    def get_user
      @user = User.find(params.require(:user_id))
    end
  end
end
