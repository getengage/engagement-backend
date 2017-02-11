module Dashboard
  class DetailsController < ApplicationController
    before_action :get_api_key, only: :show

    def show
      @result = Event::EventsProcessed.find_by(uuid: uuid_param)
      @source_url = @result.source_url
      @scores_from_past_days = Event::EventsProcessed.scores_from_past_days(@api_key.uuid, @source_url, past_days)
      @scores_from_past_week = Event::EventsProcessed.scores_from_past_week(@api_key.uuid, @source_url)[0]
      @mean_viewport_time = @scores_from_past_days.map(&:mean_viewport_time).compact
      @line_chart = LineChartPresenter.new(titles: ["Engage Score", "Time on Page"],
                                  labels: @scores_from_past_days.map(&:day),
                                  data: datasets)
    end

    def datasets
      [
        @scores_from_past_days.map{|x| x.mean_score.to_f},
        @scores_from_past_days.map{|x| x.mean_viewport_time.to_f}
      ]
    end

    def past_days
      @past_days = params.fetch(:past_days, 7).to_i
    end

    protected
    def get_api_key
      @api_key = ApiKey.find_by_uuid(api_key_param)
    end

    def uuid_param
      params.require(:uuid)
    end

    def api_key_param
      params.require(:event_id)
    end
  end
end
