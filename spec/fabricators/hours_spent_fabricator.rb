Fabricator(:hours_spent) do
  task     nil
  hour     1
  description 'Malt hus'
  date { Time.now }
end
