Fabricator(:hours_spent) do
  hour     0
  description 'Malt hus'
  date { Time.now }
  task { Fabricate(:task) }
end
