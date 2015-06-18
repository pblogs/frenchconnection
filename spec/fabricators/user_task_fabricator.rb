# == Schema Information
#
# Table name: user_tasks
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  task_id    :integer          not null
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:user_task) do
  user { Fabricate :user }
  task { Fabricate :task }
  status :pending
end
