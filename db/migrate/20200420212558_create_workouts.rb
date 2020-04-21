class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.references :training_routine, null: false, foreign_key: true
      t.string :name
      t.integer :classes_to_attend
      t.integer :status

      t.timestamps
    end
  end
end
