FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {"Abcxyz@gmail.com"}
    password {Faker::Internet.password(min_length: 10, max_length: 20)}
  end
end
