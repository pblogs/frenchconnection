json.array!(@kids) do |kid|
  json.extract! kid, :id, :references, :name, :birth_date, :sole_custody
  json.url kid_url(kid, format: :json)
end
