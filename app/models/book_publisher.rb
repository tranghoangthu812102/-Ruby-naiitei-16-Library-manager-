class BookPublisher < ApplicationRecord
  belongs_to :book, dependent: :destroy
  belongs_to :publisher
end
