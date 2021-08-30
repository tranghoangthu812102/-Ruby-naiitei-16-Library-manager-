require "rails_helper"
RSpec.describe Author, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(Settings.validate.name.max_length) }
  end

  describe "associations" do
    it { should have_many :books }
  end
end
