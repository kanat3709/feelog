# frozen_string_literal: true

class ChangeDefaultIsPublicOnPosts < ActiveRecord::Migration[8.1]
  def change
    change_column_default :posts, :is_public, from: true, to: false
  end
end