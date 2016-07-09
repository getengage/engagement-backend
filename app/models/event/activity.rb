module Event
  class Activity
    def self.find_by_api_key
      results = InfluxDB::Rails.client.query "select * from events where api_key = '1234'"
      Event::ActivityCollection.new(results.first)
    end
  end
end
