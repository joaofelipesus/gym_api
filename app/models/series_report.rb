class SeriesReport < ApplicationRecord
  belongs_to :exercise_report
  validates_presence_of :weight_used, :sequence_index
  after_create :complete_exercise_report

  private 

    def complete_exercise_report
      series_number = self.exercise_report.workout_exercise.series_number
      series_reports_size = self.exercise_report.series_reports.size
      self.exercise_report.update(status: :complete) if series_reports_size == series_number
    end

end
