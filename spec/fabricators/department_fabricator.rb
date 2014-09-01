Fabricator(:department) do
  title  { "Department #{ Random.rand(1100) } - #{ Random.rand(1100)} " }
end
