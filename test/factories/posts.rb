# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'MyString' }
    memo { 'MyText' }
    place { 'MyString' }
    latitude { '9.99' }
    longitude { '9.99' }
    visited_at { '2026-04-28' }
    is_public { false }
    user { nil }
  end
end
