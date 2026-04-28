# frozen_string_literal: true

class PostEmotion < ApplicationRecord
  belongs_to :post
  belongs_to :emotion
end
