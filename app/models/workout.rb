class Workout < ApplicationRecord
  belongs_to :training_routine
  enum status: {
    progress: 1,
    complete: 2
  }
end
