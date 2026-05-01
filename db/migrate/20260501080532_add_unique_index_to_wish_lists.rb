class AddUniqueIndexToWishLists < ActiveRecord::Migration[7.0]
  def change
    add_index :wish_lists, [:user_id, :post_id], unique: true
  end
end