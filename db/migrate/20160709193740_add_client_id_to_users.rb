class AddClientIdToUsers < ActiveRecord::Migration[4.1]
  def change
    add_column :users, :client_id, :integer, index: true
  end
end
