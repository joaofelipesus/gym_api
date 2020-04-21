class Workout < ApplicationRecord
  belongs_to :training_routine
  enum status: {
    progress: 1,
    complete: 2
  }
  validates_presence_of :name
  validates_with WorkoutUniqueNameValidator
end
