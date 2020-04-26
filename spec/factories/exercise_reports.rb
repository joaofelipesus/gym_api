FactoryBot.define do
  factory :exercise_report do
    workout_report { WorkoutReport.last }
    weight { 15 }
    workout_exercise { WorkoutExercise.last }
  end
end
