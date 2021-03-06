# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170412005357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "api_keys", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["uuid"], name: "index_api_keys_on_uuid"
  end

  create_table "client_api_keys", id: false, force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "api_key_id", null: false
    t.index ["api_key_id"], name: "index_client_api_keys_on_api_key_id"
    t.index ["client_id"], name: "index_client_api_keys_on_client_id"
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "events_processed", id: :serial, force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.string "api_key_id", null: false
    t.string "source_url", null: false
    t.string "session_id"
    t.string "referrer"
    t.boolean "reached_end_of_content"
    t.integer "total_in_viewport_time"
    t.integer "word_count"
    t.float "final_score", null: false
    t.string "city"
    t.string "region"
    t.string "country"
    t.string "remote_ip"
    t.string "user_agent"
    t.float "q1_time"
    t.float "q2_time"
    t.float "q3_time"
    t.float "q4_time"
    t.datetime "created_at"
    t.datetime "timestamp"
    t.string "tags"
    t.index "to_tsvector('english'::regconfig, (tags)::text)", name: "events_processed_gin_tags", using: :gin
  end

  create_table "events_raw", id: :serial, force: :cascade do |t|
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_1", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_10", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_11", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_12", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_2", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_3", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_4", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_5", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_6", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_7", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_8", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "events_raw_9", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('events_raw_id_seq'::regclass)" }, null: false
    t.datetime "timestamp", null: false
    t.string "referrer"
    t.float "x_pos"
    t.float "y_pos"
    t.boolean "is_visible"
    t.boolean "in_viewport"
    t.float "top"
    t.float "bottom"
    t.integer "word_count"
    t.string "remote_ip"
    t.string "user_agent"
    t.string "api_key_id", null: false
    t.string "session_id", null: false
    t.string "source_url", null: false
    t.datetime "created_at"
    t.string "tags"
  end

  create_table "imports", id: :serial, force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "cutoff", null: false
    t.string "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.jsonb "data", default: "{}", null: false
    t.string "url"
    t.string "created_by", null: false
    t.integer "client_id"
    t.string "type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_summaries", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "api_key_id", null: false
    t.integer "frequency", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["api_key_id"], name: "index_report_summaries_on_api_key_id"
    t.index ["user_id"], name: "index_report_summaries_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role"
    t.integer "client_id"
    t.string "avatar"
    t.integer "permissions", default: 0, null: false
    t.jsonb "metadata", default: "{}", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["metadata"], name: "index_users_on_metadata", using: :gin
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "report_summaries", "api_keys"
  add_foreign_key "report_summaries", "users"
  create_trigger("events_raw_before_insert_row_tr", :generated => true, :compatibility => 1).
      on("events_raw").
      before(:insert).
      declare("partition text") do
    <<-SQL_ACTIONS
          partition := quote_ident(TG_RELNAME || '_' || date_part('month', NEW.timestamp));
          IF NEW.created_at IS NULL THEN
              NEW.created_at := NOW();
          END IF;
          EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING id;';
          RETURN NULL;
    SQL_ACTIONS
  end

  create_trigger("api_keys_after_insert_row_tr", :generated => true, :compatibility => 1).
      on("api_keys").
      after(:insert).
      declare("partition text; idx_api_key_id text; idx_source_url text") do
    <<-SQL_ACTIONS
      partition := quote_ident('events_processed' || '_' || NEW.uuid);
      idx_api_key_id := quote_ident('idx_' || NEW.uuid || '_on_api_key_id');
      idx_source_url := quote_ident('idx_' || NEW.uuid || '_on_source_url');
      EXECUTE 'CREATE TABLE ' || partition || ' (check (api_key_id = ''' || NEW.uuid || ''')) INHERITS (events_processed);';
      EXECUTE 'CREATE INDEX ' || idx_api_key_id || ' ON ' || partition || ' (api_key_id);';
      EXECUTE 'CREATE INDEX ' || idx_source_url || ' ON ' || partition || ' (source_url);';
      RETURN NULL;
    SQL_ACTIONS
  end

  create_trigger("events_processed_before_insert_row_tr", :generated => true, :compatibility => 1).
      on("events_processed").
      before(:insert).
      declare("partition text") do
    <<-SQL_ACTIONS
          partition := quote_ident(TG_RELNAME || '_' || NEW.api_key_id);
          IF NEW.created_at IS NULL THEN
              NEW.created_at := NOW();
          END IF;
          EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING id;';
          RETURN NULL;
    SQL_ACTIONS
  end

end
