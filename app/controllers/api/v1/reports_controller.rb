module Api::V1
  class ReportsController < ApiController
    def create
      binding.pry
      data = {
        values: data_params,
        timestamp: Time.now.to_i
      }

      # InfluxDB::Rails.write_point(data)
    end

    def data_params
      params.require(:data)
    end
  end
end
