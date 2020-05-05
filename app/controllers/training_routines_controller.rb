class TrainingRoutinesController < ApplicationController

  def create
    @training_routine = TrainingRoutine.new training_routine_params
    if @training_routine.save
      render json: { training_routine: training_routine_json }, status: :created
    else
      render_errors_json
    end
  end

  def update
    @training_routine = TrainingRoutine.find params[:id]
    return complete_training_routine if training_routine_params[:status].present?
    if @training_routine.update training_routine_params
      update_ok_json
    else
      render_errors_json
    end
  end

  def progress
    @training_routine = TrainingRoutine.where(user_id: current_user.id).progress.first
    if @training_routine
      render json: { training_routine: training_routine_json }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def can_be_complete
    training_routine = current_user.training_routines.progress.last
    if training_routine
      render json: { can_be_complete: training_routine.can_be_complete? }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  private 

    def render_errors_json
      render json: { errors: @training_routine.errors.full_messages }, status: :unprocessable_entity
    end

    def update_ok_json
      render json: { training_routine: @training_routine }, status: :ok
    end

    def complete_training_routine
      if @training_routine.complete
        return update_ok_json
      else
        return render_errors_json
      end
    end

    def training_routine_params
      params.require(:training_routine).permit(:user_id, :status)
    end

    def training_routine_json
      @training_routine.as_json(:include => { workouts: { :include => :workout_reports }})
    end

end
