FactoryBot.define do
  factory :exercise_report do
    workout_report { WorkoutReport.last }
    workout_exercise { WorkoutExercise.last }
  end
end
