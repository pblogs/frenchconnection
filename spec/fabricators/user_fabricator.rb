Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  email      { Faker::Internet.email }
  mobile     { Faker::Base.numerify('########') }
  password { 'topsecret' }
  password_confirmation { 'topsecret' }
  department_id { Random.rand(1100) }
  emp_id { Random.rand(1100) }
end
