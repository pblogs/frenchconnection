json.array!(@locations) do |location|
  json.extract! location, :id, :name, :certificates_id, :indoor, :outdoor
  json.url location_url(location, format: :json)
end
