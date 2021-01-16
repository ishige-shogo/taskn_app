FactoryBot.define do
  factory :room do
    name { Faker::Lorem.characters(number:10) }
    goal { Faker::Lorem.characters(number:10) }
    roompass { "roompass" }
    roompass_confirmation { "roompass" }
    user
  end
end
