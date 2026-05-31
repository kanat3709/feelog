# frozen_string_literal: true

Geocoder.configure(
  lookup: :google,
  api_key: ENV['GOOGLE_MAPS_API_KEY'],
  language: :ja,
  units: :km
)