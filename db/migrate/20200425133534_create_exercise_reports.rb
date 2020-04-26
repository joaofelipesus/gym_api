class CreateExerciseReports < ActiveRecord::Migration[6.0]
  def change
    create_table :exercise_reports do |t|
      t.references :workout_report, null: false, foreign_key: true
      t.float :weight
      t.references :workout_exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
