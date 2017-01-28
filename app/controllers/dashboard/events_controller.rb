module Dashboard
  class EventsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @query_results = Event::EventsProcessed.where(api_key: @api_key)
        @url_aggregates = Event::EventsProcessed.top_scores_and_visits(@api_key.uuid)[0]
        @top_visits_by_source_url    = @url_aggregates.top_visits.map{|x| OpenStruct.new(x) }
        @top_scores_by_source_url    = @url_aggregates.top_scores.map{|x| OpenStruct.new(x) }
        @top_referrals_by_source_url = @url_aggregates.top_referrers.map{|x| OpenStruct.new(x) }
        @visits_bar_chart = BarChartPresenter.new("Unique Visits by URL", @top_visits_by_source_url)
        @scores_bar_chart = BarChartPresenter.new("Scores by URL", @top_scores_by_source_url)
        @referrals_bar_chart = BarChartPresenter.new("Referrals by URL", @top_referrals_by_source_url)
      end
    end

    def index
      @api_keys = current_user.api_keys
    end

    def api_key_param
      params.require(:id)
    end
  end
end
