module Api::V1
  class ApiKeysController < ApiController
    def create
      user = User.find(user_params)
      user.api_keys.
    end

    def user_params
      params.permit(:user_id, :name)
    end
  end
end