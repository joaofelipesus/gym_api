FactoryBot.define do
  factory :workout_report do
    workout { Workout.last }
    date { Date.current }
    status { :progress }
  end
end
