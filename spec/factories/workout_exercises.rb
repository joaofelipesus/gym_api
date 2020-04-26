FactoryBot.define do
  factory :workout_exercise do
    exercise { Exercise.last }
    workout { Workout.last }
    repetitions { 10 }
    rest_time { 60 }
    series_number { 3 }
  end
end
