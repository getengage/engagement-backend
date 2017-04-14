module Dashboard
  class DetailsController < ApplicationController
    def show
      @scores_from_past_days = Event::EventsProcessed.scores_from_past_days(api_key_uuid, source_url, past_days)
      @scores_from_past_week = Event::EventsProcessed.scores_from_past_week(api_key_uuid, source_url)[0]
      @mean_viewport_time = @scores_from_past_days.map(&:mean_viewport_time).compact
      @line_chart = LineChartPresenter.new(titles: ["Engage Score", "Time on Page"],
                                  labels: @scores_from_past_days.map(&:day),
                                  data: datasets)
    end

    protected

    def api_key_uuid
      @api_key_uuid ||= api_key.uuid
    end

    def api_key
      @api_key ||= ApiKey.find_by_uuid(api_key_param)
    end

    def api_key_param
      params.require(:event_id)
    end

    def datasets
      @scores_from_past_days.map do |val|
        [val.mean_score.to_f, val.mean_viewport_time.to_f]
      end.transpose
    end

    def past_days
      @past_days = params.fetch(:past_days, 7).to_i
    end

    def result
      @result ||= Event::EventsProcessed.find_by(uuid: uuid_param)
    end

    def source_url
      @source_url ||= result.source_url
    end

    def uuid_param
      params.require(:uuid)
    end
  end
end
