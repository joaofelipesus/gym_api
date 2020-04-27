FactoryBot.define do
  factory :series_report do
    exercise_report { nil }
    sequence_index { 1 }
    weight_used { 1.5 }
  end
end
