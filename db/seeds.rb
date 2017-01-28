Event::Import.create(status: 1, cutoff: Time.current)

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

client = Client.where(name: "FooCompany").first_or_create
user.update(client: client)
puts 'CREATED CLIENT: ' << client.name

["my_key", "another_key", "another_one"].each do |key|
  api_key = ApiKey.where(name: key).first_or_create
  ClientApiKey.where(client: client, api_key: api_key).first_or_create

end

sources = ["usatoday.com", "newyorker.com", "huffingtonpost.com", "nytimes.com",
           "yahoo.com", "nbcnews.com", "reddit.com", "espn.com",
           "financialtimes.com", "slate.com"]

timestamp        = Time.current
second_timestamp = timestamp - 1.hour
uuid             = ApiKey.first.uuid

number_of_events = 200

1.upto(number_of_events) do |n|

  # First User Session, reached end
  Event::EventsRaw.where(
    timestamp: timestamp,
    session_id: SecureRandom.uuid,
    source_url: "example.com/1/#{n}",
    x_pos: 10,
    top: 0,
    bottom: number_of_events * 10,
    y_pos: n * 10,
    is_visible: true,
    in_viewport: true,
    api_key_id: uuid,
    word_count: 200,
    referrer: "example.com/1/#{n}",
    remote_ip: "24.29.18.175"
  ).first_or_create

  # Second User Session, didn't reach end
  Event::EventsRaw.where(
    timestamp: second_timestamp,
    session_id: SecureRandom.uuid,
    source_url: "example.com/2/#{n}",
    x_pos: 10,
    top: 0,
    bottom: number_of_events * 10,
    y_pos: n * 9,
    is_visible: true,
    in_viewport: true,
    api_key_id: uuid,
    word_count: 200,
    referrer: "example.com/1/#{n}",
    remote_ip: "24.29.18.175"
  ).first_or_create
end

puts 'CREATED EVENTS: ' << uuid
