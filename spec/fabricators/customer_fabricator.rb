Fabricator(:customer) do
  name           { Faker::Company.name }
  address        { Faker::Address.street_name } 
  org_number    { Random.new_seed.to_s[0..6] }
  customer_nr    { Random.new_seed.to_s[0..6] }
  contact_person { Faker::Name.first_name }
  phone     { Faker::Base.numerify('########') }
end
