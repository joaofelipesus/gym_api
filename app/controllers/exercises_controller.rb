class ExercisesController < ApplicationController

  def create
    exercise = Exercise.new exercise_params
    if exercise.save
      render json: exercise, status: :created
    else
      render json: exercise.errors.full_messages, status: :unprocessable_entity
    end
  end

  private 

    def exercise_params
      params.require(:exercise).permit(:name)
    end

end
