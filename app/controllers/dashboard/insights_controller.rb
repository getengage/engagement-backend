module Dashboard
  class InsightsController < ApplicationController
    def show
      @api_key = ApiKey.find_by_uuid(api_key_param)
    end

    protected

    def api_key_param
      params.require(:id)
    end
  end
end
