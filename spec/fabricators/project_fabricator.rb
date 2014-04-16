Fabricator(:project) do
  project_number "PL1"
  name           "Project for nice customer"
  customer       { Fabricate(:customer) }
  start_date     { Time.now }
end
