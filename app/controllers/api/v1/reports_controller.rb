module Api::V1
  class ReportsController < ApiController
    def create
      Rails.logger.info params
    end
  end
end
