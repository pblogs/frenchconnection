Fabricator(:inventory) do
  name                             "Bulldozer"
  description                      "5 tons of Cat"
  booked_from                      "2014-12-03"
  booked_to                        "2014-12-03"
  can_be_rented_by_other_companies false
  rental_price_pr_day              1
end
