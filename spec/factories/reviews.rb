FactoryBot.define do
  factory :review do
    association :user
    reviewable_type { "Book" }
    rate { 4.5 }
    detail { "hay" }
  end
end
