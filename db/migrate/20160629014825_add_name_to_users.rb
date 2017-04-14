class AddNameToUsers < ActiveRecord::Migration[4.1]
  def change
    add_column :users, :name, :string
  end
end
