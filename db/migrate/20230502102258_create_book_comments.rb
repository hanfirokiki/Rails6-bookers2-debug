class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|
      t.integer :id_false
      t.text :comment
      t.integer :user_id
      t.timestamps
    end
  end
end
