module Event
  class EventsProcessed < ActiveRecord::Base
    def self.partition_key
      'NEW.api_key_id'
    end

    scope :top_scores_and_visits, ->(api_key_id, limit=5) {
      select(
        "json_agg(json_build_object('source_url', source_url, 'count', top_score) order by final_score_rk asc) FILTER (where final_score_rk <= #{limit}) as top_scores,
         json_agg(json_build_object('source_url', top_referrer, 'count', referrer_rk) order by referrer_rk asc) FILTER (where referrer_rk <= #{limit}) as top_referrers,
         json_agg(json_build_object('source_url', source_url, 'count', source_url_ct) order by source_url_rk asc) FILTER (where source_url_rk <= #{limit}) as top_visits"
      ).
      from(aggregate_counts(api_key_id))
    }

    scope :aggregate_counts, ->(api_key_id) {
      select(
        "source_url,
         avg(final_score) as mean_score,
         min(uuid::varchar) as uuid,
         max(final_score) as top_score,
         max(referrer) as top_referrer,
         min(timestamp) as first_timestamp,
         max(timestamp) as last_timestamp,
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
         count(distinct session_id) FILTER (where final_score >= #{ENGAGED_THRESHOLD}) as engaged_visits"
      ).
      from(
        "GENERATE_SERIES(
          DATE(#{sanitize(Date.current)}) - INTERVAL '#{sanitize(days - 1)} days',
          DATE(#{sanitize(Date.current)}),
          '1 day'
        ) series"
      ).
      joins(
        "left outer join events_processed ON date(events_processed.timestamp) = series and
         api_key_id = #{sanitize(api_key_id)} and source_url = #{sanitize(source_url)}"
      ).
      group('day').
      order('day')
    }

    scope :scores_from_past_week, ->(api_key_id, source_url, limit=4) {
      select(
        "*,
        round(coalesce((mean_score / lag(mean_score, 1) over (order by day)) * 100, 0)) as mean_score_pt_change,
        round(coalesce((top_score / lag(top_score, 1) over (order by day)) * 100, 0)) as top_score_pt_change"
      ).
      from(
        select(
          "avg(final_score) as mean_score,
           max(final_score) as top_score,
           avg(q1_time) as q1_time,
           avg((q1_time / total_in_viewport_time) * 100) as q1_time_pt,
           avg(q2_time) as q2_time,
           avg((q2_time / total_in_viewport_time) * 100) as q2_time_pt,
           avg(q3_time) as q3_time,
           avg((q3_time / total_in_viewport_time) * 100) as q3_time_pt,
           avg(q4_time) as q4_time,
           avg((q4_time / total_in_viewport_time) * 100) as q4_time_pt,
           date_trunc('week', timestamp) as day"
        ).
        where(api_key_id: api_key_id, source_url: source_url).
        group('day').
        order('day')
      ).
      order('day desc').
      limit(limit)
    }

    include Base
  end
end
