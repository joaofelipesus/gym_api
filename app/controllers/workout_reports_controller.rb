class WorkoutReportsController < ApplicationController

  def create  
    workout_report = WorkoutReport.new workout_report_params
    if workout_report.save
      render json: { workout_report: workout_report }, status: :ok
    else
      render json: { errors: workout_report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def progress
    @workout_report = WorkoutReport
                                .progress
                                .joins(workout: [:training_routine])
                                .where("training_routines.user_id = ?", current_user.id)
                                .last
    if @workout_report
      render json: { workout_report: workout_report_json }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def update
    workout_report = WorkoutReport.find params[:id]
    if workout_report.update workout_report_params
      render json: { workout_report: workout_report }, status: :ok
    else
      render json: { errors: workout_report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def workout_report_params
      params.require(:workout_report).permit(:workout_id, :status)
    end

    def workout_report_json
      @workout_report.as_json(include: [:workout, exercise_reports: {
        include: [workout_exercise: {
          include: [:exercise]
        }]
      }])
    end 

end
