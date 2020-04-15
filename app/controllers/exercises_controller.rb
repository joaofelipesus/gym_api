class ExercisesController < ApplicationController

  def index
    exercises = Exercise.all.order(:name).page params[:page]
    render json: { exercises: exercises }, status: :ok
  end

  def create
    exercise = Exercise.new exercise_params
    if exercise.save
      render json: exercise, status: :created
    else
      render json: { errors: exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private 

    def exercise_params
      params.require(:exercise).permit(:name)
    end

end
