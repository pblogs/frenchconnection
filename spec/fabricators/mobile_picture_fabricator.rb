Fabricator(:mobile_picture) do
  task        { Fabricate(:task) }
  user        { Fabricate(:user) }
  url         "http://alliero.orwapp.com/assets/Alliero-header-cd52ac88e9edf6e748c7ef4245954826.gif"
  description "Alliero header"
  project     { Fabricate(:project) }
end
