module Dashboard
  class EventsController < ApplicationController
    def show
      @api_key = ApiKey.find_by_uuid(api_key_param)
      @url_aggregates = Event::EventsProcessed.aggregate_counts(@api_key.uuid)
    end

    protected

    def api_key_param
      params.require(:id)
    end
  end
end
