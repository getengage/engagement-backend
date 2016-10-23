module Api::V1
  class UsersController < ApiController
    def update
      user = User.find(params.require(:id))
      user.update(user_params)
      render({json: {id: user.id}})
    end

    def user_params
      params.require(:user).permit(:name, :avatar)
    end
  end
end