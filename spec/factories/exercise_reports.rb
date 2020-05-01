FactoryBot.define do
  factory :exercise_report do
    workout_report { WorkoutReport.last }
    workout_exercise { WorkoutExercise.last }
    status { :progress }
  end
end
