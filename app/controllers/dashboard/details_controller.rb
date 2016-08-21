module Dashboard
  class DetailsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @result = Event::Score.find(uid_param)
      end
    end

    def uid_param
      params.require(:id)
    end

    def api_key_param
      params.require(:event_id)
    end
  end
end
