FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
    password { Faker::Internet.password}
    after(:create) {|user| user.add_role(:newuser)}

    trait :theatre_administrator do
      after(:create) {|user| user.add_role(:theatre_administrator)}
    end

    trait :admin do
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end
