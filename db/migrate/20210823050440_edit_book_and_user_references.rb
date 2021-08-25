class EditBookAndUserReferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :requests, :user, null: false, foreign_key: true
    add_reference :requests, :book, null: false, foreign_key: true
    remove_column :requests, :users_id
    remove_column :requests, :books_id
  end
end
