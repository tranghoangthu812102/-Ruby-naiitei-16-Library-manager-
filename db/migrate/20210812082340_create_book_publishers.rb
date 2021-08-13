class CreateBookPublishers < ActiveRecord::Migration[6.1]
  def change
    create_table :book_publishers, :id => false do |t|
      t.references :book, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true
    end
  end
end
