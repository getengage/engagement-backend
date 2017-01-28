class SimplePgCursor
  attr_reader :sql, :cursor, :connection, :opts, :model

  delegate :execute, :exec_query, to: :connection

  def initialize(model, sql, **opts)
    @model      = model
    @sql        = sql
    @opts       = opts.reverse_merge(default_opts)
    @connection = @opts[:connection]
  end

  def run(&block)
    optional_transaction do
      begin
        open_cursor
        while rows = fetch_rows
          break if rows.size==0
          block.call(rows)
          break if rows.size < opts[:fetch_count]
        end
      rescue Exception => e
         raise e
      ensure
        close_cursor
      end
    end
  end

  protected
  def default_opts
    {
      fetch_count: 100,
      connection: ::ActiveRecord::Base.connection,
      hold: false
    }
  end

  def fetch_rows
    exec_query("fetch #{opts[:fetch_count]} from cursor_#{cursor}").to_hash
  end

  def open_cursor
    @cursor = SecureRandom.uuid.gsub("-","")
    hold = opts[:hold] ? 'with hold ' : ''
    execute("declare cursor_#{@cursor} no scroll cursor #{hold}for #{sql}")
  end

  def close_cursor
    execute("close cursor_#{cursor}")
  end

  def optional_transaction
    if opts[:hold]
      yield
    else
      model.transaction { yield }
    end
  end
end
