# frozen_string_literal: true

Geocoder.configure(
  lookup: :google,
  api_key: ENV.fetch('GOOGLE_MAPS_API_KEY', nil),
  language: :ja,
  units: :km
)
