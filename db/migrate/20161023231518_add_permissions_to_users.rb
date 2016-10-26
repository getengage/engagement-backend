class AddPermissionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permissions, :integer, default: 0, null: false
  end
end
