class TrainingRoutinesController < ApplicationController

  def create
    training_routine = TrainingRoutine.new treaining_routine_params
    if training_routine.save
      render json: { training_routine: training_routine }, status: :created
    else
      render json: { errors: training_routine.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private 

    def treaining_routine_params
      params.require(:training_routine).permit(:user_id)
    end

end
