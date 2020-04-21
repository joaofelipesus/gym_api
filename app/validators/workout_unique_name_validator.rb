class WorkoutUniqueNameValidator < ActiveModel::Validator

  def validate record
    training_routine = record.training_routine
    return unless training_routine
    current_names = training_routine.workouts.map { |workout| workout.name }
    if current_names.include? record.name
      record.errors[:name] << "já está em uso para esta rotina de treinos"
    end
  end

end