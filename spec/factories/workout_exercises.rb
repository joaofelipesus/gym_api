FactoryBot.define do
  factory :workout_exercise do
    exercise { nil }
    workout { nil }
    repetitions { 1 }
    rest_time { 1 }
    reference_weight { 1.5 }
  end
end
