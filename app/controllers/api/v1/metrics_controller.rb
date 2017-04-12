module Api::V1
  class MetricsController < ApiController
    def create
      insert          = Arel::Nodes::InsertStatement.new
      insert.relation = Arel::Table.new(:events_raw)
      insert.columns  = value_params.keys.map { |k| Arel::Table.new(:events_raw)[k] }
      insert.values   = Arel::Nodes::Values.new(value_params.values, insert.columns)

      ActiveRecord::Base.connection.execute(insert.to_sql)
    end

    def data_params
      @params ||= params.require(:data)
    end

    def value_params
      data_params.
        permit(:timestamp, :api_key_id, :session_id, :source_url,
               :referrer, :x_pos, :y_pos, :is_visible,
               :in_viewport, :top, :bottom, :word_count,
               :tags).
        merge(remote_ip: request.remote_ip, user_agent: request.user_agent)
    end
  end
end
