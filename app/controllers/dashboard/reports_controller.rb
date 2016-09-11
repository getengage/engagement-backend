module Dashboard
  class ReportsController < ApplicationController
    def index
      @api_keys = current_user.api_keys
    end
  end
end
