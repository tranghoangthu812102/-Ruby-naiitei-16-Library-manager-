require "rails_helper"
RSpec.describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:number_of_page) }
    it do
      should validate_numericality_of(:number_of_page).only_integer
               .is_greater_than(Settings.zero)
    end
    it { should validate_length_of(:name).is_at_most(Settings.validate.name.max_length) }
  end

  describe "associations" do
    it { should belong_to :author }
  end

  describe "nested_attributes" do
    it { should accept_nested_attributes_for(:book_categories) }
  end
end
