# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170101223646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "api_keys", force: :cascade do |t|
    t.string   "name",                                      null: false
    t.uuid     "uuid",       default: "uuid_generate_v4()"
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_keys", ["uuid"], name: "index_api_keys_on_uuid", using: :btree

  create_table "client_api_keys", id: false, force: :cascade do |t|
    t.integer "client_id",  null: false
    t.integer "api_key_id", null: false
  end

  add_index "client_api_keys", ["api_key_id"], name: "index_client_api_keys_on_api_key_id", using: :btree
  add_index "client_api_keys", ["client_id"], name: "index_client_api_keys_on_client_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "events_processed", force: :cascade do |t|
    t.string   "api_key_id",             null: false
    t.string   "source_url",             null: false
    t.string   "session_id"
    t.string   "referrer"
    t.boolean  "reached_end_of_content"
    t.integer  "total_in_viewport_time"
    t.integer  "word_count"
    t.float    "final_score",            null: false
    t.string   "city"
    t.string   "region"
    t.string   "country"
    t.string   "remote_ip"
    t.datetime "created_at"
  end

  create_table "events_raw", force: :cascade do |t|
    t.datetime "timestamp",   null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",  null: false
    t.string   "session_id",  null: false
    t.string   "source_url",  null: false
    t.datetime "created_at"
  end

  create_table "events_raw_1", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_1", ["api_key_id"], name: "index_events_raw_1_on_api_key_id", using: :btree

  create_table "events_raw_10", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_10", ["api_key_id"], name: "index_events_raw_10_on_api_key_id", using: :btree

  create_table "events_raw_11", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_11", ["api_key_id"], name: "index_events_raw_11_on_api_key_id", using: :btree

  create_table "events_raw_12", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_12", ["api_key_id"], name: "index_events_raw_12_on_api_key_id", using: :btree

  create_table "events_raw_2", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_2", ["api_key_id"], name: "index_events_raw_2_on_api_key_id", using: :btree

  create_table "events_raw_3", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_3", ["api_key_id"], name: "index_events_raw_3_on_api_key_id", using: :btree

  create_table "events_raw_4", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_4", ["api_key_id"], name: "index_events_raw_4_on_api_key_id", using: :btree

  create_table "events_raw_5", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_5", ["api_key_id"], name: "index_events_raw_5_on_api_key_id", using: :btree

  create_table "events_raw_6", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_6", ["api_key_id"], name: "index_events_raw_6_on_api_key_id", using: :btree

  create_table "events_raw_7", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_7", ["api_key_id"], name: "index_events_raw_7_on_api_key_id", using: :btree

  create_table "events_raw_8", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_8", ["api_key_id"], name: "index_events_raw_8_on_api_key_id", using: :btree

  create_table "events_raw_9", id: false, force: :cascade do |t|
    t.integer  "id",          default: "nextval('events_raw_id_seq'::regclass)", null: false
    t.datetime "timestamp",                                                      null: false
    t.string   "referrer"
    t.float    "x_pos"
    t.float    "y_pos"
    t.boolean  "is_visible"
    t.boolean  "in_viewport"
    t.float    "top"
    t.float    "bottom"
    t.integer  "word_count"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "api_key_id",                                                     null: false
    t.string   "session_id",                                                     null: false
    t.string   "source_url",                                                     null: false
    t.datetime "created_at"
  end

  add_index "events_raw_9", ["api_key_id"], name: "index_events_raw_9_on_api_key_id", using: :btree

  create_table "imports", force: :cascade do |t|
    t.integer  "status"
    t.string   "message"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_summaries", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "api_key_id",             null: false
    t.integer  "frequency",  default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "report_summaries", ["api_key_id"], name: "index_report_summaries_on_api_key_id", using: :btree
  add_index "report_summaries", ["user_id"], name: "index_report_summaries_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.integer  "client_id"
    t.string   "avatar"
    t.integer  "permissions",            default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

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
