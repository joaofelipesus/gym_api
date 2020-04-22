FactoryBot.define do
  factory :workout do
    training_routine { TrainingRoutine.last }
    name { Faker::Name.name }
    classes_to_attend { 10 }
    status { :progress }
    workout_exercises {[build(:workout_exercise)]}
  end
end
