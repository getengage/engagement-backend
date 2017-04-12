FactoryGirl.define do
  factory :events_processed, class: Event::EventsProcessed do
    timestamp { '2017-08-19' }
    uuid { SecureRandom.uuid }
    api_key
    source_url Faker::Internet.url
    session_id { SecureRandom.uuid }
    referrer Faker::Internet.url
    reached_end_of_content true
    total_in_viewport_time 200
    word_count { rand(500) }
    final_score { rand(250) }
    city "New York"
    country "United States"
    remote_ip Faker::Internet.ip_v4_address
    user_agent "Android"
    q1_time { rand(50) }
    q2_time { rand(50) }
    q3_time { rand(50) }
    q4_time { rand(50) }
  end
end
