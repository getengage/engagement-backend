class Event::ScoresJob < ActiveJob::Base
  queue_as :default

  def perform
    Sidekiq::Client.push("queue" => "go_queue",
                         "class" => "RegressionWorker",
                         "args" => [])
  end
end
