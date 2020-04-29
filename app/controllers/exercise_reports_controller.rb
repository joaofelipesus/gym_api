class ExerciseReportsController < ApplicationController

  def show
    @exercise_report = ExerciseReport.find params[:id]
    render json: { exercise_report: exercise_report_json, last_series: last_series }, status: :ok  #, include: [:series_reports, :workout_report, workout_exercise: { include: [:exercise]}]
  end

  private 

    def exercise_report_json
      @exercise_report.as_json(include: [:series_reports, :workout_report, workout_exercise: { include: [:exercise]}])
    end

    def last_series
      ExerciseReport
                  .joins(workout_exercise: [workout: [:training_routine]])
                  .where("training_routines.user_id = ?", current_user.id)
                  .order(created_at: :desc)
                  .first
                  .series_reports
    end

end
