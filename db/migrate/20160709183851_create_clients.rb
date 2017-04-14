class CreateClients < ActiveRecord::Migration[4.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false
    end
  end
end
