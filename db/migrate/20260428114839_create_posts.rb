class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :memo
      t.string :place
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.date :visited_at
      t.boolean :is_public, null: false, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end