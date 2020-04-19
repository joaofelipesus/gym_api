class CreateTrainingRoutines < ActiveRecord::Migration[6.0]
  def change
    create_table :training_routines do |t|
      t.references :user, null: false, foreign_key: true
      t.date :started_at
      t.date :finished_at
      t.integer :status
      
      t.timestamps
    end
  end
end
