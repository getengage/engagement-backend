class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def subnav_hidden?
    @subnav_hidden ||= false
  end
  helper_method :subnav_hidden?

  def dashboard_sections
    ["events", "notifications", "reports", "insights"]
  end
  helper_method :dashboard_sections

  def hide_subnav
    @subnav_hidden = true
  end
end
