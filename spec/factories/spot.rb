
FactoryBot.define do
  factory :spot do
    name { Faker::Lorem.characters(number: 10) }
    address { Faker::Address }
    introduction { Faker::Lorem.characters(number: 20) }
    association :user
    association :overseas_area

    after(:build) do |built_spot|
      built_spot.spot_images << FactoryBot.build(:spot_image, spot: built_spot)
    end
  end

  factory :spot_image do
   image_id  { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.png"), 'image/png') }
  end

end