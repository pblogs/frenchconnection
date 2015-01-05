# == Schema Information
#
# Table name: tasks
#
#  id               :integer          not null, primary key
#  customer_id      :integer
#  start_date       :date
#  created_at       :datetime
#  updated_at       :datetime
#  accepted         :boolean
#  description      :string(255)
#  finished         :boolean          default(FALSE)
#  project_id       :integer
#  due_date         :date
#  ended_at         :datetime
#  work_category_id :integer
#  location_id      :integer
#  profession_id    :integer
#  skills_ids       :integer
#

Fabricator(:task) do
  start_date = Time.now
  due_date   = Time.now.next_week

  project     { Fabricate(:project,start_date: start_date, due_date: due_date) }
  start_date  { start_date }
  due_date    { due_date }
  description { 'paint building' }
  accepted true
end
