json.array!(@artisans) do |artisan|
  json.extract! artisan, :id, :name, :tasks_id
  json.url artisan_url(artisan, format: :json)
end
