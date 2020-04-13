FactoryBot.define do
  factory :exercise do
    name { Faker::Name.name }
    status { :active }
  end
end
