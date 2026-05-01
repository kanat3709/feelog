class CreateWishLists < ActiveRecord::Migration[8.1]
  def change
    create_table :wish_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
