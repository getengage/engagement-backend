module Event
  class EventProcessInsert
    include Sidekiq::Worker

    def perform(*args)
      parsed_res = JSON.parse(args.first)
      columns = JSON.parse(parsed_res.first).keys

      to_insert = parsed_res.map do |r|
        parsed_row = JSON.parse(r)
        vals = columns.map {|k| parsed_row[k] }
        ActiveRecord::Base.send(:replace_bind_variables, "(#{vals.length.times.collect {'?'}.join(',')})", vals)
      end

      ActiveRecord::Base.connection.execute(<<-SQL)
        INSERT INTO events_processed
        (#{columns.join(',')})
        VALUES #{to_insert.join(",")}
      SQL
    end
  end
end
