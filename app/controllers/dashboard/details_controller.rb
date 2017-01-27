module Dashboard
  class DetailsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @result = Event::EventsProcessed.find_by(uuid: uid_param)
        @source_url = @result.source_url
        @mean_scores_from_past_days = Event::EventsProcessed.mean_scores_from_past_days(@api_key.uuid, @source_url)
        @unique_visits_from_past_days = Event::EventsProcessed.unique_visits_from_past_days(@api_key.uuid, @source_url)
        @scores_from_past_days = Event::EventsProcessed.mean_scores_from_past_days(@api_key.uuid, @source_url)
        @median_score = Event::EventsProcessed.median_score_alltime(@api_key.uuid, @source_url)
        @line_chart = LineChartPresenter.new(title: "Last 15 Day Engagement Scores",
                                    labels: (15.days.ago.to_date..Date.today).map{ |date| date.to_s(:day_and_mo) },
                                    data: @mean_scores_from_past_days.map{|x| x.mean.to_f})
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
