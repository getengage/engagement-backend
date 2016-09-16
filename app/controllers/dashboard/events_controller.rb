module Dashboard
  class EventsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @query_results = Event::Score.find_by_api_key(@api_key.uuid)
        @top_scores_by_source_url = Event::Score.top_scores_by_source_url(@api_key.uuid)
        @bar_chart = BarChartPresenter.new(title: "Unique Visits by URL",
                                           labels: @top_scores_by_source_url.values.map{|x| x.source_url.truncate(30) },
                                           data: @top_scores_by_source_url.values.map(&:count))
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
