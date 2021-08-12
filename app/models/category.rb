class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
end
