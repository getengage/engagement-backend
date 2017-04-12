module Dashboard
  class ReportsController < ApplicationController
    before_action :hide_subnav

    def index
      @report_summaries = current_user.report_summaries.includes(:api_key)
      @api_keys = current_user.api_keys.where.not(id: @report_summaries.pluck(:api_key_id))
    end

    def create
      @report_summary = current_user.report_summaries.create(report_summary_params)
      render @report_summary
    end

    def report_summary_params
      params.require(:report_summary).permit(:api_key_id, :frequency)
    end
  end
end
