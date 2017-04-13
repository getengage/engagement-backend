class Api::V1::MetricsController < Api::V1::ApiController
  def create
    insert = Insert.new(
      relation: events_raw_table,
      columns: mapped_params,
      values: Arel::Nodes::Values.new(value_params.values, mapped_params)
    )
    ActiveRecord::Base.connection.execute(insert.to_sql)
  end

  protected

  def events_raw_table
    @events_raw_table ||= Arel::Table.new(:events_raw)
  end

  def data_params
    @data_params ||= params.require(:data)
  end

  def value_params
    data_params.
      permit(:timestamp, :api_key_id, :session_id, :source_url,
             :referrer, :x_pos, :y_pos, :is_visible,
             :in_viewport, :top, :bottom, :word_count,
             :tags).
      merge(remote_ip: request.remote_ip, user_agent: request.user_agent)
  end

  def mapped_params
    @mapped_params ||= value_params.keys.map do |key|
      events_raw_table[key]
    end
  end
end
