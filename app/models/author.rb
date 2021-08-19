class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true,
            length: {
              maximum: Settings.validate.name.max_length
            }
end
