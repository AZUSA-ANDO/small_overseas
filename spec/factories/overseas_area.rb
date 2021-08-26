FactoryBot.define do
  factory :overseas_area do
  name{ Faker::Lorem.characters(number: 10) }
  end
end