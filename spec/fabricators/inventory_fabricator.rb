# == Schema Information
#
# Table name: inventories
#
#  id                               :integer          not null, primary key
#  name                             :string(255)
#  description                      :string(255)
#  certificates_id                  :integer
#  can_be_rented_by_other_companies :boolean          default(FALSE)
#  rental_price_pr_day              :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#

Fabricator(:inventory) do
  name                             { Faker::Lorem.word }
  description                      "5 tons of Cat"
  can_be_rented_by_other_companies false
  rental_price_pr_day              1
end

