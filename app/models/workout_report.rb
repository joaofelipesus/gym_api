class WorkoutReport < ApplicationRecord
  belongs_to :workout
  enum status: {
    progress: 1,
    complete: 2
  }
  validates_presence_of :status, :date
  before_validation :set_status

  private 

    def set_status
      self.status = :progress unless self.status
    end
end
