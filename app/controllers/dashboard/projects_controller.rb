module Dashboard
  class ProjectsController < ApplicationController
    before_action :hide_subnav
    before_action :keep_flash_if_signin_redirect, only: :index

    def show
      @api_key = ApiKey.find_by_uuid(api_key_param)
      @aggregate_counts = Event::EventsProcessed.aggregate_counts(@api_key.uuid)
    end

    def index
      @api_keys = current_user.api_keys
      redirect_to dashboard_tutorials_path if @api_keys.blank?
    end

    protected

    def api_key_param
      params.require(:id)
    end
  end
end
