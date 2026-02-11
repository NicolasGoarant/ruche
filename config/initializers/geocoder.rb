Geocoder.configure(
  lookup: :nominatim,
  timeout: 5,
  language: :fr,
  cache: Rails.cache,
  cache_prefix: "geocoder:",
  http_headers: {
    "User-Agent" => "Ruche App (contact@ruche.example)"
  },
  units: :km,
  distances: :linear
)
