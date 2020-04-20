FactoryBot.define do
  factory :workout do
    training_routine { nil }
    name { "MyString" }
    classes_to_attend { 1 }
    status { 1 }
  end
end
