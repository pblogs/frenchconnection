json.array!(@user_languages) do |user_language|
  json.extract! user_language, :id, :rating
  json.url user_language_url(user_language, format: :json)
end
