FactoryBot.define do
  factory :comment do
    association :user
    association :spot
    opinion { Faker::Lorem.characters(number: 20) }

  end
end