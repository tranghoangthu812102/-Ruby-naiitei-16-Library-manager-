class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  def book
    reviewable if reviewable_type == Book.name
  end
end
