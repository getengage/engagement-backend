class CreateImports < ActiveRecord::Migration[4.1]
  def change
    create_table :imports do |t|
      t.integer :status, null: false, default: 0
      t.string :message
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :cutoff, null: false
      t.string :type
      t.timestamps
    end
  end
end
