class Event::EventProcessJob < ActiveJob::Base
  queue_as 'default'

  def perform
  end
end
