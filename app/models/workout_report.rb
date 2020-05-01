class WorkoutReport < ApplicationRecord
  belongs_to :workout
  enum status: {
    progress: 1,
    complete: 2
  }
  validates_presence_of :status, :date
  before_validation :set_status, :set_date
  has_many :exercise_reports
  after_create :generate_exercise_reports

  private 

    def set_status
      self.status = :progress unless self.status
    end

    def set_date 
      self.date = Date.current unless self.date
    end

    def generate_exercise_reports
      self.workout.workout_exercises.each do |workout_exercise|
        ExerciseReport.create(workout_report: self, workout_exercise: workout_exercise)
      end
    end

end
