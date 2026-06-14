# frozen_string_literal: true

FactoryBot.define do
  factory :test_user, class: User do
    name { Faker::Name.name }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    terms_of_service { '1' }
  end
end
