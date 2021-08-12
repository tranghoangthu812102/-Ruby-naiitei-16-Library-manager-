class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :reviewable_id
      t.string :reviewable_type
      t.float :rate
      t.text :detail
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
