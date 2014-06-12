Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  email      { Faker::Internet.email }
  mobile     { Faker::PhoneNumber.cell_phone }
  password { 'topsecret' }
  password_confirmation { 'topsecret' }
end
