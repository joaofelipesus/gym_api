class CreateWorkoutExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :workout_exercises do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.integer :repetitions
      t.integer :rest_time
      t.float :reference_weight

      t.timestamps
    end
  end
end
