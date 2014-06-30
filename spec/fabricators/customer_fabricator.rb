Fabricator(:customer) do
  name           { Faker::Company.name }
  address        { Faker::Address.street_address }
  org_number     { Faker::Company.duns_number }
  contact_person { Faker::Name.name }
  phone          { Faker::Base.numerify('########') }
end
