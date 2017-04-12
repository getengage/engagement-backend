module Dashboard
  class NotificationsController < ApplicationController
    def show
      @api_key = ApiKey.find_by_uuid(api_key_param)
      @notifications = current_user.all_notifications
    end

    protected

    def api_key_param
      params.require(:id)
    end
  end
end
