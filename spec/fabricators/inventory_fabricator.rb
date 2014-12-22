Fabricator(:inventory) do
  name                             { Faker::Lorem.word }
  description                      "5 tons of Cat"
  can_be_rented_by_other_companies false
  rental_price_pr_day              1
end

