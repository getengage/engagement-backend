module Event
  class Score < InfluxCollection
    def self.find(uuid)
      query("select * from #{influx_table} where uuid = '%s'", uuid)
    end

    def self.find_by_api_key(api_key)
      query("select last(score) as score, referrer, source_url, uuid from #{influx_table} where api_key = '%s' group by source_url", api_key)
    end

    def self.mean_scores_from_15_days(source_url, api_key)
      query("select mean(score) from #{influx_table} where api_key = '%s' and source_url = '%s' and time > now() - 15d group by time(1d)", api_key, source_url)
    end

    def self.top_visits_by_source_url(api_key)
      query("select top(count, 5) as count, source_url from unique_visits_1d")
    end

    def self.top_scores_by_source_url(api_key)
      query("select top(mean, 5) as count, source_url from mean_scores_1d")
    end

    def self.top_referrals_by_source_url(api_key)
      query("select top(count, 5) as count, source_url from referrals_1d")
    end
  end
end