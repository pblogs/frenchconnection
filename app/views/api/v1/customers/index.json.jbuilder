json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :address, :org_number, :contact_person, :phone
  json.url customer_url(customer, format: :json)
end
