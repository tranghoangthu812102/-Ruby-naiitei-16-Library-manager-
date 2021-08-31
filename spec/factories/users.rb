FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "Abcxyz@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end

  factory :admin, class: User do
    name { Faker::Name.name }
    email { "hello@gmail.com" }
    password { Faker::Internet.password(min_length: 10, max_length: 20) }
    role { "admin" }
  end
end
