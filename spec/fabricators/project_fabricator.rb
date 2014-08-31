Fabricator(:project) do
  project_number "PL1"
  name           { Faker::Company.name }
  customer       { Fabricate(:customer) }
  start_date     { Time.now }
  due_date       { Time.now.next_week }
  description    "Lag en ny port ved innkjøringen til parkeringen "
  department      { Fabricate(:department) }
end
