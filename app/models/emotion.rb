# frozen_string_literal: true

class Emotion < ApplicationRecord
  has_many :post_emotions, dependent: :destroy
  has_many :posts, through: :post_emotions

  validates :name, presence: true, uniqueness: true
end
