# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  enum :role, { general: 0, admin: 1 }

  attr_accessor :terms_of_service

  validates :name, presence: true
  validates :terms_of_service, acceptance: true, unless: :provider?

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :wish_lists, dependent: :destroy

  has_one_attached :avatar

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.terms_of_service = true
    end
  end
end
