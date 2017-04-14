class Api::V1::UsersController < Api::V1::ApiController
  def update
    user = User.find(params.require(:id))
    user.update(user_params)
    render({json: {id: user.id}})
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :permissions)
  end
end
