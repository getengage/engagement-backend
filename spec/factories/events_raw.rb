FactoryGirl.define do
  factory :events_raw, class: Event::EventsRaw do
    timestamp Date.current
    referrer Faker::Internet.url
    x_pos { rand(900) }
    y_pos { rand(2000) }
    is_visible true
    in_viewport true
    top 0
    bottom 2000
    word_count 1000
    remote_ip Faker::Internet.ip_v4_address
    user_agent "Chrome"
    session_id { SecureRandom.uuid }
    source_url Faker::Internet.url
    api_key
  end
end
