class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  PERMITTED = %i(detail rate).freeze

  validates :detail, presence: true

  validates :rate, presence: true,
            numericality: {
              less_than_or_equal_to: Settings.review.less,
              greater_than_or_equal_to: Settings.review.greater
            }

  def book
    reviewable if reviewable_type == Book.name
  end
end
