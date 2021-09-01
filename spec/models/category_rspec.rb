require "rails_helper"
RSpec.describe Category, type: :model do
  let(:category) {FactoryBot.create :category}
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(Settings.validation.min_length) }
    it { should validate_length_of(:name).is_at_most(Settings.validation.max_length) }
  end

  describe "associations" do
    it { should have_many :book_categories }
  end

  describe "associations" do
    it { should have_many :books }
  end

  describe "scope" do
    it { expect(Category.search("hi")).to eq([category]) }
  end
end
