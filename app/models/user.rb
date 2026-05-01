# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :terms_of_service

  validates :name, presence: true
  validates :terms_of_service, acceptance: true

  has_many :posts, dependent: :destroy # 追加

  has_one_attached :avatar
end
