module Api::V1
  class ReportsController < ApiController
    def create
      session = Cassandra.cluster.connect(keyspace)

      data_params = OpenStruct.new
      data_params.values = ["testtest#{rand(99999)}", '102022', '20203', 'http://google.com', '3', '3', true, 'http://google.com']

      events_by_source = session.prepare('INSERT INTO events_by_source (api_key, session_id, uuid, referrer_url, x_pos, y_pos, page_visible, source_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)')
      events_by_session_id = session.prepare('INSERT INTO events_by_session_id (api_key, session_id, uuid, referrer_url, x_pos, y_pos, page_visible, source_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)')
      events_by_uuid = session.prepare('INSERT INTO events_by_uuid (api_key, session_id, uuid, referrer_url, x_pos, y_pos, page_visible, source_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)')

      batch = session.batch do |batch|
        batch.add(events_by_source, data_params.values)
        batch.add(events_by_session_id, data_params.values)
        batch.add(events_by_uuid, data_params.values)
      end

      session.execute(batch)
    end

    def data_params
      params.require(:data)
    end
  end
end
