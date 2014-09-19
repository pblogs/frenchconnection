Fabricator(:user_task) do
  user { Fabricate :user }
  task { Fabricate :task }
  status :pending
end
