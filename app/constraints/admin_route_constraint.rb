class AdminRouteConstraint
  def matches?(request)
    user = request.env["warden"].user(:user)
    user.present? && user.admin?
  end

  def current_user(request)
    User.find_by_id(request.session[:user_id])
  end
end
