module Dashboard
  class EventsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @query_results = Event::Score.find_by_api_key(@api_key.uuid)
      end
    end

    def index
      @api_keys = current_user.api_keys
    end

    def api_key_param
      params.require(:id)
    end
  end
end
