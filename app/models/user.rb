class User < ApplicationRecord
  before_save :downcase_email

  PERMITTED_FIELDS = %i(name email password password_confirmation image).freeze

  has_one_attached :image

  has_many :reviews, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
           foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
           foreign_key: :followed_id, dependent: :destroy

  validates :name, presence: true,
            length: {
              maximum: Settings.validate.name.max_length
            }
  validates :email, presence: true,
            length: {
              minimum: Settings.validate.email.min_length,
              maximum: Settings.validate.email.max_length
            },
            format: {with: Settings.validate.email.format},
            uniqueness: {case_sensitive: Settings.validate.email.case_sensitive}
  validates :password, presence: true,
            length: {
              minimum: Settings.validate.password.min_length
            }
  validates :image, content_type: {in: Settings.image_restricted_types,
                                   message: I18n.t("invalid_format_image")},
            size: {less_than: Settings.max_image_size.megabytes,
                   message: I18n.t(".should_smaller")}

  enum role: {admin: 0, member: 1}

  has_secure_password

  def display_image
    image.variant resize_to_limit: Settings.avatar_size_limit
  end

  private

  def downcase_email
    email.downcase!
  end
end
