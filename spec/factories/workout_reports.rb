FactoryBot.define do
  factory :workout_report do
    workout { nil }
    date { "2020-04-24" }
    status { 1 }
  end
end
