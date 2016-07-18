module Api::V1
  class ReportsController < ApiController
    def create
      data = {
        tags: tag_params,
        values: value_params
      }
      InfluxDB::Rails.client.write_point("events", data.merge(timestamp_param))
    end

    def data_params
      @params ||= params.require(:data)
    end

    def tag_params
      data_params.permit(:api_key, :session_id, :source_url)
    end

    def timestamp_param
      data_params.permit(:timestamp)
    end

    def value_params
      data_params.permit(:referrer, :x_pos, :y_pos, :is_visible)
    end
  end
end
