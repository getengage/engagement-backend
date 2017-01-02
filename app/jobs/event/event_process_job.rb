module Event
  class EventProcessJob < ActiveJob::Base
    queue_as 'default'

    after_perform do |job|
      Import.successful.where(cutoff: @cutoff).first_or_create
    end

    def perform
      @cutoff = 30.minutes.ago

      Event::EventsRaw.
        by_month(Date.current.month).
        where(timestamp: Import.latest.cutoff..@cutoff).
        group(:source_url, :session_id, :id).find_each do |event|
          #
        end
    end
  end
end
