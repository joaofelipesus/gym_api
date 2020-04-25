class CreateWorkoutReports < ActiveRecord::Migration[6.0]
  def change
    create_table :workout_reports do |t|
      t.references :workout, null: false, foreign_key: true
      t.date :date
      t.integer :status

      t.timestamps
    end
  end
end
