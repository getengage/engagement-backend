class AddNotificationsToUsers < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    add_column :users, :notifications, :hstore, default: '', null: false
  end
end
