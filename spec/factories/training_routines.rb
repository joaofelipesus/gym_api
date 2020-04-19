FactoryBot.define do
  factory :training_routine do
    user { nil }
    started_at { "2020-04-19" }
    finished_at { "2020-04-19" }
    status { 1 }
    classes_to_attend { 1 }
    has_class_limit { false }
  end
end
