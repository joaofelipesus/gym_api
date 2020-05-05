class TrainingRoutine < ApplicationRecord
  belongs_to :user
  validates_presence_of :status
  before_validation :set_status
  enum status: {
    progress: 1,
    complete: 2
  }
  has_many :workouts, -> { order('name ASC') }

  def can_be_complete?
    return false if self.workouts.empty?
    has_complete = self.workouts.includes(:workout_reports).map do |workout|
      workout.classes_to_attend <= workout.workout_reports.complete.size
    end
    has_complete.all?(true)
  end

  def complete
    if self.update({ status: :complete, finished_at: Date.current })
      self.workouts.each { |workout| workout.update(status: :complete) }
      return true
    end
    false
  end

  private

    def set_status
      self.status = :progress unless self.status
    end

end
