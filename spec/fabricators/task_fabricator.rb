Fabricator(:task) do
  project         { Fabricate(:project) }
  start_date      { 1.days.since }
  due_date        { 3.days.since }
  accepted true
end
