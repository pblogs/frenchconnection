Fabricator(:department) do
  title { "#{ Faker::Commerce.department } #{ Random.rand(1100) }" }
end
