class ApplicationController < ActionController::Base
  include ReactOnRails::Controller
  protect_from_forgery with: :exception
  before_action :set_redux

  def set_redux
    redux_store("SettingsStore", props: redux_props)
  end

  def redux_props
    return {} unless flash[:notice]
    @redux_props = {
      notifications: [
        {
          message: flash[:notice],
          position: "br"
        }
      ]
    }
  end

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

  def keep_flash_if_signin_redirect
    flash.keep(:notice) if request.referrer == new_session_url(current_user)
  end
end
