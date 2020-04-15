class ExercisesController < ApplicationController

  def index
    exercises = Exercise.all.order(:name).page params[:page]
    render json: { exercises: exercises, total_pages: exercises.total_pages }, status: :ok
  end

  def create
    exercise = Exercise.new exercise_params
    if exercise.save
      render json: exercise, status: :created
    else
      render json: { errors: exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    exercise = Exercise.find params[:id]
    if exercise.update exercise_params
      render json: {exercise: exercise }, status: :ok
    else
      render json: { errors: exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private 

    def exercise_params
      params.require(:exercise).permit(:name, :status)
    end

end
