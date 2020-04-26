class WorkoutReportsController < ApplicationController

  def create  
    workout_report = WorkoutReport.new workout_report_params
    if workout_report.save
      render json: { workout_report: workout_report }, status: :ok
    else
      render json: { errors: workout_report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def workout_report_params
      params.require(:workout_report).permit(:workout_id)
    end

end
