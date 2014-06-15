Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  email      { Faker::Internet.email }
  mobile     { Fabricate.sequence(:number, 93000000) }
  password { 'topsecret' }
  password_confirmation { 'topsecret' }
end
