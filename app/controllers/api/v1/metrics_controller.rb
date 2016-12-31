module Api::V1
  class MetricsController < ApiController
    def create
      Event::EventsRaw.create(value_params)
    end

    def data_params
      @params ||= params.require(:data)
    end

    def value_params
      data_params.
        permit(:timestamp, :api_key_id, :session_id, :source_url,
               :referrer, :x_pos, :y_pos, :is_visible,
               :in_viewport, :top, :bottom, :word_count).
        merge(remote_ip: request.remote_ip, user_agent: request.user_agent)
    end
  end
end
