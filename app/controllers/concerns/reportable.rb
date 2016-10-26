module Reportable
  extend ActiveSupport::Concern

  included do
    has_many :report_summaries, class_name: "Report::Summary"
    has_many :report_summary_users, through: :report_summaries, source: :user
  end
end