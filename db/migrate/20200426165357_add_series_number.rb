class AddSeriesNumber < ActiveRecord::Migration[6.0]
  def change
    add_column :workout_exercises, :suries_number, :integer 
  end
end
