class Reports::SummaryJob < ActiveJob::Base
  queue_as :default

  def perform(frequency)
    ApiKey.
      joins(:report_summary_users).
      merge(Report::Summary.send(frequency)).
      merge(User.allow_all).
      find_each do |api_key|
        data = {
          last_10_visits: Event::Score.find_by_api_key(api_key.uuid),
          top_visits_by_source: Event::Score.top_visits_by_source_url(api_key.uuid),
          top_scores_by_source_url: Event::Score.top_scores_by_source_url(api_key.uuid)
        }
        emails = api_key.report_summary_users.map(&:email)
        Reports::SummaryMailer.notify(emails, data, api_key.name).deliver_now
      end
  end
end
