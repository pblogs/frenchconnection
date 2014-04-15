Fabricator(:project) do
  project_number "PL1"
  name           "Project for nice customer"
  customer        { Fabricate(:customer) }
end
