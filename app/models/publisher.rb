class Publisher < ApplicationRecord
  has_many :book_publishers, dependent: :destroy
end
