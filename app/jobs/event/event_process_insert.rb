module Event
  class EventProcessJob < ActiveJob::Base
    queue_as 'go_queue_b'

    def perform(*args)
      puts args
      Rails.logger.info(args)
    end
  end
end
