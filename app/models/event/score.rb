module Event
  class Score < InfluxCollection
    def self.find(uuid)
      results = InfluxDB::Rails.client.query "select * from #{influx_table} where uuid = '#{uuid}'"
      new(results.first)
    end

    def self.find_by_api_key(api_key)
      results = InfluxDB::Rails.client.query "select * from #{influx_table} where api_key = '#{api_key}'"
      new(results.first)
    end

    def self.mean_scores_from_15_days(source_url, api_key)
      results = InfluxDB::Rails.client.query "select mean(score) from #{influx_table} where api_key = '#{api_key}' and source_url = '#{source_url}' and time > now() - 15d group by time(1d)"
      new(results.first)
    end

    def self.top_visits_by_source_url(api_key)
      results = InfluxDB::Rails.client.query("select top(count, 5) as count, source_url from unique_visits_1d")
      new(results.first)
    end

    def self.top_scores_by_source_url(api_key)
      results = InfluxDB::Rails.client.query("select top(mean, 5) as count, source_url from mean_scores_1d")
      new(results.first)
    end

    def self.top_referrals_by_source_url(api_key)
      results = InfluxDB::Rails.client.query("select top(count, 5) as count, source_url from referrals_1d")
      new(results.first)
    end
  end
end