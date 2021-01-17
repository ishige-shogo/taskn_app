FactoryBot.define do
  factory :memo do
    body { Faker::Lorem.characters(number:10) }
    user
    room
  end
end
