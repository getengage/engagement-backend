class AddAvatarToUsers < ActiveRecord::Migration[4.1]
  def change
    add_column :users, :avatar, :string
  end
end
