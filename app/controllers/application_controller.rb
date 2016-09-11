class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def subnav_hidden?
    @subnav_hidden ||= false
  end
  helper_method :subnav_hidden?

  def dashboard_sections
    ["events", "settings", "reports"]
  end
  helper_method :dashboard_sections

end
