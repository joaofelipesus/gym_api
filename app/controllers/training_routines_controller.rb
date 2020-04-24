class TrainingRoutinesController < ApplicationController

  def create
    @training_routine = TrainingRoutine.new treaining_routine_params
    if @training_routine.save
      render json: { training_routine: training_routine_json }, status: :created
    else
      render json: { errors: training_routine.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def progress
    @training_routine = TrainingRoutine.where(user_id: params[:user_id]).progress.first
    if @training_routine
      render json: { training_routine: training_routine_json }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  private 

    def treaining_routine_params
      params.require(:training_routine).permit(:user_id)
    end

    def training_routine_json
      @training_routine.to_json(:include => { workouts: { :include => :workout_reports }})
    end

end
