# frozen_string_literal: true

class WishList < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  scope :visited, -> { where(visited: true) }
  scope :not_visited, -> { where(visited: false) }
end
