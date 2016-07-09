module Dashboard
  class EventsController < ApplicationController
    def show
      @api_key = ApiKey.find(api_key_param)
      @query_results = Event::Activity.find_by_api_key
    end

    def api_key_param
      params.require(:id)
    end
  end
end
