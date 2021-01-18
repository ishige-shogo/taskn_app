FactoryBot.define do
  factory :task do
    body { Faker::Lorem.characters(number: 10) }
    importance { Random.rand(3) }
    user
    room
  end
end
