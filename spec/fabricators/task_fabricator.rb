Fabricator(:task) do
  project       { Fabricate(:project) }
  task_type     { Fabricate(:task_type) }
  start_date    "2014-04-06 10:55:29"
  due_date       { Time.now.next_week }
  accepted true
end
