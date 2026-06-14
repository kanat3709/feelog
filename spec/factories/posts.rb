# frozen_string_literal: true

FactoryBot.define do
  factory :travel_post, class: Post do
    title { Faker::Lorem.sentence(word_count: 3) }
    memo { Faker::Lorem.paragraph }
    place { Faker::Address.city }
    visited_at { Faker::Date.backward(days: 365) }
    is_public { true }
    association :user
  end
end
