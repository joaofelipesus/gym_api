class ExerciseReport < ApplicationRecord
  belongs_to :workout_report
  belongs_to :workout_exercise
  enum status: {
    progress: 0,
    complete: 1
  }
  before_validation :set_status
  has_many :series_reports
  
  private

    def set_status
      self.status = :progress unless self.status
    end

end
