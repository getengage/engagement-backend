user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

client = Client.where(name: "FooCompany").first_or_create
user.update(client: client)
puts 'CREATED CLIENT: ' << client.name

["my_key", "another_key", "another_one"].each do |key|
  api_key = ApiKey.where(name: key).first_or_create
  ClientApiKey.where(client: client, api_key: api_key).first_or_create
  puts 'CREATED API KEY: ' << api_key.name
end

sources = ["usatoday.com", "newyorker.com", "huffingtonpost.com", "nytimes.com",
           "yahoo.com", "nbcnews.com", "reddit.com", "espn.com",
           "financialtimes.com", "slate.com"]

# sources.each do |source|
#   40.times do
#     tags = {
#       "uuid": SecureRandom.hex,
#       "source_url": "#{source}/news/article-content-#{rand(5)}",
#       "api_key": api_key.uuid
#     }
#
#     values = {
#       "session_id": SecureRandom.hex,
#       "referrer": "google.com",
#       "reached_end_of_content": true,
#       "total_in_viewport_time": Random.new.rand(200..400),
#       "word_count": Random.new.rand(200..400),
#       "score": Random.new.rand(100..250),
#       "remote_ip": IPAddr.new(rand(2**32),Socket::AF_INET).to_s,
#       "city": ["New York", "Los Angeles", "Miami"].sample,
#       "country": "United States"
#     }
#
#     data = {
#       tags: tags,
#       values: values,
#       timestamp: (Time.now.to_i - rand(20).days).to_i
#     }
#
#     InfluxDB::Rails.client.write_point("event_scores", data)
#   end
# end
