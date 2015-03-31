json.array!(@dynamic_forms) do |dynamic_form|
  json.extract! dynamic_form, :id, :field_name, :populate, :autocomplete_from, :title
  json.url dynamic_form_url(dynamic_form, format: :json)
end
