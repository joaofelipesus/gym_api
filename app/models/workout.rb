class Workout < ApplicationRecord
  belongs_to :training_routine
  enum status: {
    progress: 1,
    complete: 2
  }
  validates_presence_of :name, :workout_exercises
  validates_with WorkoutUniqueNameValidator
  has_many :workout_exercises
  before_validation :set_status
  accepts_nested_attributes_for :workout_exercises
  has_many :workout_reports, -> { order('created_at ASC') }

  private

    def set_status
      self.status = :progress unless self.status
    end

end
