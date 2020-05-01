class RemoveWeightFromExerciseReport < ActiveRecord::Migration[6.0]
  def change
    remove_column :exercise_reports, :weight
  end
end
