FactoryBot.define do
  factory :exercise_report do
    workout_report { nil }
    weight { 1.5 }
    workout_exercise { nil }
  end
end
