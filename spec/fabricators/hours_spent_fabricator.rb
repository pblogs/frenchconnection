Fabricator(:hours_spent) do
  hour     0
  description 'Malt hus'
  date        { Time.now }
  task        { Fabricate(:task) }
  project     { Fabricate(:project) }
  user        { Fabricate(:user) }
end
