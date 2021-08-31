require "rails_helper"
RSpec.describe BookCategory, type: :model do
  describe "associations" do
    it { should belong_to :book }
    it { should belong_to :category }
  end
end
