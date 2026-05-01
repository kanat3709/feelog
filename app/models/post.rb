# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :post_emotions, dependent: :destroy
  has_many :emotions, through: :post_emotions
  has_many :likes, dependent: :destroy
  has_many :wish_lists, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true
  validates :is_public, inclusion: { in: [true, false] }
end
