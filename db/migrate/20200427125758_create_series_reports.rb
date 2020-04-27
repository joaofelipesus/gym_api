class CreateSeriesReports < ActiveRecord::Migration[6.0]
  def change
    create_table :series_reports do |t|
      t.references :exercise_report, null: false, foreign_key: true
      t.integer :sequence_index
      t.float :weight_used

      t.timestamps
    end
  end
end
