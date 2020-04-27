FactoryBot.define do
  factory :series_report do
    exercise_report { ExerciseReport.last }
    sequence_index { 1 }
    weight_used { 75 }
  end
end
