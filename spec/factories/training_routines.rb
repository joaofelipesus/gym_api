FactoryBot.define do
  factory :training_routine do
    user { User.user.last }
    started_at { "2020-04-19" }
    finished_at { "2020-04-19" }
    status { :progress }
    classes_to_attend { 1 }
    has_class_limit { true }
  end
end
