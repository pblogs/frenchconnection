# == Schema Information
#
# Table name: customers
#
#  id             :integer          not null, primary key
#  name           :string
#  address        :string
#  org_number     :string
#  contact_person :string
#  phone          :string
#  created_at     :datetime
#  updated_at     :datetime
#  customer_nr    :integer
#  area           :string
#  email          :string
#

Fabricator(:customer) do
  name           { Faker::Company.name }
  address        { Faker::Address.street_address }
  org_number     { Random.new_seed.to_s[0..6] }
  customer_nr    { Random.new_seed.to_s[0..6] }
  contact_person { Faker::Name.first_name }
  phone          { Faker::Base.numerify('########') }
end
