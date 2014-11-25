Fabricator(:favorite) do
  favorable { Fabricate(:project) }
  user { Fabricate(:user) }
end
