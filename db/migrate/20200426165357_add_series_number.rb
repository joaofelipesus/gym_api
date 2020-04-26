class AddSeriesNumber < ActiveRecord::Migration[6.0]
  def change
    add_column :workout_exercises, :series_number, :integer 
  end
end
