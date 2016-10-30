module Dashboard
  class DetailsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @result = Event::Score.find(uid_param)
        @source_url = @result.first.source_url
        @mean_scores_from_15_days = Event::Score.mean_scores_from_15_days(@source_url, @api_key.uuid)
        @unique_visits_from_15_days = Event::Score.unique_visits_from_15_days(@source_url, @api_key.uuid)
        @scores_from_30_days = Event::Score.scores_from_30_days(@source_url, @api_key.uuid)
        @median_score = Event::Score.median_score_alltime(@source_url, @api_key.uuid)
        @line_chart = LineChartPresenter.new(title: "Last 15 Day Engagement Scores",
                                    labels: (15.days.ago.to_date..Date.today).map{ |date| date.to_s(:day_and_mo) },
                                    data: @mean_scores_from_15_days.map{|x| x.mean.to_f})
        @scatter_chart = ScatterChartPresenter.new(title: "Time on Page and Engage Score",
                                    labels: (30.days.ago.to_date..Date.today).map{ |date| date.to_s(:day_and_mo) },
                                    data: @scores_from_30_days)
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
