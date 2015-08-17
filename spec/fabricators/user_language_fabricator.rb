Fabricator(:user_language) do
  rating 1
  user { Fabricate(:user) }
  language { Fabricate(:language) }
end
