module Event
  class EventsProcessed < ActiveRecord::Base
    def self.partition_key
      'NEW.api_key_id'
    end

    scope :top_scores_and_visits, ->(api_key_id, limit=5) {
      select(
        "json_agg(json_build_array(source_url, top_score) order by final_score_rk asc) FILTER (where final_score_rk <= #{limit}) as top_scores,
         json_agg(json_build_array(source_url, top_referrer) order by referrer_rk asc) FILTER (where referrer_rk <= #{limit}) as top_referrers,
         json_agg(json_build_array(source_url, source_urL_ct) order by source_url_rk asc) FILTER (where source_url_rk <= #{limit}) as top_visits"
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

    include Base
  end
end
