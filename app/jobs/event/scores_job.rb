class Event::ScoresJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Sidekiq::Client.push("queue" => "go_queue",
                         "class" => self.class.name,
                         "args" => [])
  end
end
