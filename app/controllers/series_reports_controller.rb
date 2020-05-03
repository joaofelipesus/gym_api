class SeriesReportsController < ApplicationController

  def create
    @series_reports = series_report_params.map { |params| SeriesReport.new params }
    has_errors = check_if_series_reports_are_valid
    if has_errors.empty?
      @series_reports.each { |series_report| series_report.save } 
      render json: { series_reports: @series_reports }, status: :created
    else
      render json: { errors: has_errors }, status: :unprocessable_entity
    end
  end

  def progression
    exercise_reports = ExerciseReport
                                    .joins(workout_exercise: [workout: [:training_routine]])
                                    .where("training_routines.user_id = ?", current_user.id)
                                    .where("workout_exercises.exercise_id = ?", params[:exercise_id])
                                    .order(:created_at)
    weight_values = exercise_reports.includes(:series_reports, :workout_exercise).map do |exercise_report|
      series_number = exercise_report.workout_exercise.series_number
      weights = exercise_report.series_reports.map { |series| series.weight_used }
      mean_weight = weights.sum / series_number
      {
        date: exercise_report.created_at.to_date,
        mean_weight: mean_weight
      }
    end
    render json: { weigths_used: weight_values }, status: :ok
  end

  private 

    def series_report_params
      params.require(:series_reports).map do |param| 
        param.permit(
          :exercise_report_id, 
          :weight_used, 
          :sequence_index
        )    
      end
    end

    def check_if_series_reports_are_valid
      error_messages = []
      @series_reports.each do |series_report|
        error_messages += series_report.errors.full_messages unless series_report.valid?
      end
      error_messages.uniq
    end

end
