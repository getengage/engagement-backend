module Dashboard
  class DetailsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @result = Event::EventsProcessed.find_by(uuid: uid_param)
        @source_url = @result.source_url
        @scores_from_past_days = Event::EventsProcessed.scores_from_past_days(@api_key.uuid, @source_url)
        @mean_score = Event::EventsProcessed.mean_score_alltime(@api_key.uuid, @source_url)[0].mean_score
        @line_chart = LineChartPresenter.new(title: "Last 15 Day Engagement Scores",
                                    labels: @scores_from_past_days.map(&:day),
                                    data: @scores_from_past_days.map{|x| x.mean_score.to_f})
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
