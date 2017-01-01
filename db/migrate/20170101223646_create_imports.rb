class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer :status
      t.string :message 
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end
  end
end
