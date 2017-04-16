class CreateReportSummaries < ActiveRecord::Migration[4.2]
  def change
    create_table :report_summaries do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :api_key, index: true, foreign_key: true, null: false
      t.integer :frequency, default: 0, null: false
      t.timestamps
    end
  end
end
