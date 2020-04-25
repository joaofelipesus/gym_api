class WorkoutsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def create
    workout = Workout.new workout_params
    if workout.save
      render json: workout, status: :created, include: [:workout_exercises]
    else
      render json: { errors: workout.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    workout = Workout.find params[:id]
    render json: { workout: workout }, status: :ok, include: [:workout_reports]
  end 

  private

    def workout_params
      params.require(:workout).permit(
        :name,
        :classes_to_attend,
        :training_routine_id,
        workout_exercises_attributes: [:exercise_id, :repetitions, :rest_time]
      )
    end

end
