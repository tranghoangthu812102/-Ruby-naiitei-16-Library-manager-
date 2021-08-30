FactoryBot.define do
  factory :book_categories do
    association :book
    association :category
  end
end
