class TrainingRoutine < ApplicationRecord
  belongs_to :user
  validates_presence_of :status
  before_validation :set_status
  enum status: {
    progress: 1,
    complete: 2
  }
  has_many :workouts

  private

    def set_status
      self.status = :progress unless self.status
    end

end
