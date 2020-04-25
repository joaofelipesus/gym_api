class ExerciseReport < ApplicationRecord
  belongs_to :workout_report
  belongs_to :workout_exercise
  validates_presence_of :weight
end
