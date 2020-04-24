class WorkoutReport < ApplicationRecord
  belongs_to :workout
  enum status: {
    progress: 1,
    complete: 2
  }
end
