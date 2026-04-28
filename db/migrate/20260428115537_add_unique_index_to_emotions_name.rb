class AddUniqueIndexToEmotionsName < ActiveRecord::Migration[8.1]
  def change
    add_index :emotions, :name, unique: true
  end
end