json.array!(@professions) do |profession|
  json.extract! profession, :id, :title
  json.url profession_url(profession, format: :json)
end
