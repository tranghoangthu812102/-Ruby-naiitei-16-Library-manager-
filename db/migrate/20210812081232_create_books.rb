class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.text :detail
      t.integer :number_of_page
      t.float :rate
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
