FactoryBot.define do
  factory :training_routine do
    user { User.user.last }
    started_at { "2020-04-19" }
    finished_at { "2020-04-19" }
    status { :progress }
  end
end
