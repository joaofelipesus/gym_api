class ExerciseReportsController < ApplicationController

  def show
    exercise_report = ExerciseReport.find params[:id]
    render json: { exercise_report: exercise_report }, status: :ok, include: [:workout_report, workout_exercise: { include: [:exercise]}]
  end

end
