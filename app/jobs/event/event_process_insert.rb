module Event
  class EventProcessInsert
    include Sidekiq::Worker

    def perform(*args)
    end
  end
end
