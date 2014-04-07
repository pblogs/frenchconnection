Fabricator(:artisan) do
  name            { Faker::Name.first_name }
  tasks nil
end
