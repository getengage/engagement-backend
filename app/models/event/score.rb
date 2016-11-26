module Event
  class Score < InfluxCollection
    include ActiveModel::Model
    attr_accessor :time, :api_key, :city, :country,
                  :reached_end_of_content, :referrer,
                  :remote_ip, :score, :session_id,
                  :source_url, :total_in_viewport_time,
                  :uuid, :word_count, :count, :mean

    def self.find(uuid)
      query("select * from #{influx_table} where uuid = '%s'", uuid)
    end

    # Limited to 10
    def self.find_by_api_key(api_key)
      query("select score, referrer, source_url, uuid from #{influx_table} where api_key = '%s' order by time desc limit 10", api_key)
    end

    def self.mean_scores_from_15_days(source_url, api_key)
      query("select mean(score) from #{influx_table} where api_key = '%s' and source_url = '%s' and time > now() - 15d group by time(1d) order by time desc", api_key, source_url)
    end

    def self.unique_visits_from_15_days(source_url, api_key)
      query("select count(session_id) from #{influx_table} where api_key = '%s' and source_url = '%s' and time > now() - 15d group by time(1d) order by time desc", api_key, source_url)
    end

    def self.median_score_alltime(source_url, api_key)
      query("select median(score) as score from #{influx_table} where api_key = '%s' and source_url = '%s'", api_key, source_url)
    end

    def self.top_visits_by_source_url(api_key)
      query("select top(count, 5) as count, source_url from #{influx_table}.autogen.unique_visits_1d")
    end

    def self.top_scores_by_source_url(api_key)
      query("select top(mean, 5) as count, source_url from #{influx_table}.autogen.mean_scores_1d")
    end

    def self.scores_from_30_days(source_url, api_key)
      query("select * from #{influx_table} where api_key = '%s' and source_url = '%s' and time > now() - 30d", api_key, source_url)
    end

    def self.top_referrals_by_source_url(api_key)
      query("select top(count, 5) as count, source_url from #{influx_table}.autogen.referrals_1d")
    end
  end
end
