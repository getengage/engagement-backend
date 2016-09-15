module Dashboard
  class DetailsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @result = Event::Score.find(uid_param)
        @source_url = @result.values.first.source_url
        @mean_scores_from_15_days = Event::Score.mean_scores_from_15_days(@source_url, @api_key.uuid)
        @line_chart = LineChartPresenter.new(title: "Last 15 Day Engagement Scores",
                                    labels: (15.days.ago.to_date..Date.today).map{ |date| date.strftime("%b %d") },
                                    data: @mean_scores_from_15_days.values.map{|x| x.mean.to_f})
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
