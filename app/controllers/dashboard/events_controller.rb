module Dashboard
  class EventsController < ApplicationController
    before_action :hide_subnav, only: [:index, :show]

    def show
      @api_key = ApiKey.find_by_uuid(api_key_param)
      @url_aggregates = Event::EventsProcessed.aggregate_counts(@api_key.uuid)
    end

    def index
      @api_keys = current_user.api_keys
    end

    def api_key_param
      params.require(:id)
    end
  end
end
