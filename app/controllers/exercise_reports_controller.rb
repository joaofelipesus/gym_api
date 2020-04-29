class ExerciseReportsController < ApplicationController

  def show
    @exercise_report = ExerciseReport.includes(:workout_exercise).find params[:id]
    render json: { exercise_report: exercise_report_json, last_series: last_series }, status: :ok
  end

  private 

    def exercise_report_json
      @exercise_report.as_json(include: [:series_reports, :workout_report, workout_exercise: { include: [:exercise]}])
    end

    def last_series
      exercise_reports = ExerciseReport
                                    .joins(workout_exercise: [workout: [:training_routine]])
                                    .where("training_routines.user_id = ?", current_user.id)
                                    .where("exercise_reports.status = 1")
                                    .where("workout_exercises.id = ?", @exercise_report.workout_exercise.id)
      unless exercise_reports.empty?
        return exercise_reports.last.series_reports.order(:sequence_index)
      else
        return []
      end
    end

end
