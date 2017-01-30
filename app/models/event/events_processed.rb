module Event
  class EventsProcessed < ActiveRecord::Base
    def self.partition_key
      'NEW.api_key_id'
    end

    scope :top_scores_and_visits, ->(api_key_id, limit=5) {
      select(
        "json_agg(json_build_object('source_url', source_url, 'count', top_score) order by final_score_rk asc) FILTER (where final_score_rk <= #{limit}) as top_scores,
         json_agg(json_build_object('source_url', top_referrer, 'count', referrer_rk) order by referrer_rk asc) FILTER (where referrer_rk <= #{limit}) as top_referrers,
         json_agg(json_build_object('source_url', source_url, 'count', source_urL_ct) order by source_url_rk asc) FILTER (where source_url_rk <= #{limit}) as top_visits"
      ).
      from(aggregate_counts(api_key_id))
    }

    scope :aggregate_counts, ->(api_key_id) {
      select(
        "source_url,
         max(final_score) as top_score,
         max(referrer) as top_referrer,
         count(source_url) as source_url_ct,
         row_number() over (order by max(final_score) desc) as final_score_rk,
         row_number() over (order by max(referrer) desc) as referrer_rk,
         row_number() over (order by count(source_url) desc) as source_url_rk"
      ).
      group(:source_url).
      where(api_key_id: api_key_id)
    }

    scope :scores_from_past_days, ->(api_key_id, source_url, days=7) {
      select(
        "date(series) as day,
         avg(final_score) as mean_score,
         avg(total_in_viewport_time) as mean_viewport_time,
         count(distinct session_id) as visits,
         count(distinct session_id) FILTER (where final_score >= #{ENGAGED_TRESHOLD}) as engaged_visits"
      ).
      from(
        "GENERATE_SERIES(
          DATE(#{sanitize(Date.current)}) - INTERVAL '#{sanitize(days)} days',
          DATE(#{sanitize(Date.current)}),
          '1 day'
        ) series"
      ).
      joins(
        "left outer join events_processed ON date(events_processed.created_at) = series and
         api_key_id = #{sanitize(api_key_id)} and source_url = #{sanitize(source_url)}"
      ).
      group('day').
      order('day')
    }

    scope :mean_score_alltime, ->(api_key_id, source_url) {
      select("avg(final_score) as mean_score").
      where(api_key_id: api_key_id, source_url: source_url)
    }

    include Base
  end
end
