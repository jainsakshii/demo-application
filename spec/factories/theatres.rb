FactoryBot.define do
  factory :theatre do
    name { Faker::Name.name_with_middle }
    venue { "Indore"}
    contact_number { "12345" }
    theatre_administrator_id { nil }
    user_id { nil }
  end
end
