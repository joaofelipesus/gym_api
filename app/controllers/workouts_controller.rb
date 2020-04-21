class WorkoutsController < ApplicationController

  def create
    workout = Workout.new workout_params
    if workout.save
      render json: workout, status: :created, include: [:workout_exercises]
    else
      render json: { errors: workout.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def workout_params
      params.require(:workout).permit(
        :name,
        :classes_to_attend,
        :training_routine_id,
        workout_exercises_attributes: [:exercise_id, :repetitions, :rest_time, :reference_weight]
      )
    end

end
