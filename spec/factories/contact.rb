FactoryBot.define do
  factory :contact do
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:20) }
    user
  end
end
