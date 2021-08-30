FactoryBot.define do
  factory :book do
    name { "hello" }
    association :author
    detail { Faker::Name.name }
    number_of_page { Faker::Number.number(digits: 3) }
  end
end
