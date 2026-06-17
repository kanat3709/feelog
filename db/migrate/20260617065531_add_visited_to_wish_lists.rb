class AddVisitedToWishLists < ActiveRecord::Migration[8.1]
  def change
    add_column :wish_lists, :visited, :boolean, default: false, null: false
  end
end
