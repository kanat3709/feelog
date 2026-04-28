# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :post_emotions, dependent: :destroy
  has_many :emotions, through: :post_emotions

  validates :title, presence: true
  validates :is_public, inclusion: { in: [true, false] }
end
