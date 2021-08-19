class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  validates :name, presence: true,
            length: {minimum: Settings.validation.min_length,
                     maximum: Settings.validation.max_length}

  scope :search, ->(name){where "name LIKE ?", "%#{name}%"}
  has_many :books, through: :book_categories
end
