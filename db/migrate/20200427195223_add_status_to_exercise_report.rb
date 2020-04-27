class AddStatusToExerciseReport < ActiveRecord::Migration[6.0]
  def change
    add_column :exercise_reports, :status, :integer
  end
end
