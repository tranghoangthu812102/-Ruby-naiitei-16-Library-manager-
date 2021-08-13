class Book < ApplicationRecord
  belongs_to :author
  has_many :book_categories, dependent: :destroy
  has_many :book_publishers, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
end
