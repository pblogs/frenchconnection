# == Schema Information
#
# Table name: customers
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  address        :string(255)
#  org_number     :string(255)
#  contact_person :string(255)
#  phone          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  customer_nr    :integer
#  area           :string(255)
#  email          :string(255)
#

Fabricator(:customer) do
  name           { Faker::Company.name }
  address        { Faker::Address.street_address }
  org_number     { Random.new_seed.to_s[0..6] }
  customer_nr    { Random.new_seed.to_s[0..6] }
  contact_person { Faker::Name.first_name }
  phone          { Faker::Base.numerify('########') }
end
