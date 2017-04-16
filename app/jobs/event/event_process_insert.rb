module Event
  class EventProcessInsert
    include Sidekiq::Worker

    class ParsedResponse
      attr_reader :json

      def initialize(args)
        @json = JSON.parse(args.first)
      end

      def values
        json.map do |res|
          vals = JSON.parse(res).values
          ActiveRecord::Base.send(:replace_bind_variables, "(#{vals.length.times.collect {'?'}.join(',')})", vals)
        end
      end

      def columns
        JSON.parse(json.first).keys
      end
    end

    def perform(*args)
      response = ParsedResponse.new(args)

      ActiveRecord::Base.connection.execute(<<-SQL)
        INSERT INTO events_processed
        (#{response.columns.join(',')})
        VALUES #{response.values.join(",")}
      SQL
    end
  end
end
