class CreateBookCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :book_categories, :id => false do |t|
      t.references :book, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
    end
  end
end
