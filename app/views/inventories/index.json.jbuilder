json.array!(@inventories) do |inventory|
  json.extract! inventory, :id, :title, :description,  :certificates_id, :can_be_rented_by_other_companies, :rental_price_pr_day
  json.url inventory_url(inventory, format: :json)
end
