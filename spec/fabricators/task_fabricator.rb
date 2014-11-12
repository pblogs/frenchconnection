# == Schema Information
#
# Table name: tasks
#
#  id                     :integer          not null, primary key
#  customer_id            :integer
#  task_type_id           :integer
#  start_date             :date
#  customer_buys_supplies :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  paint_id               :integer
#  accepted               :boolean
#  description            :string(255)
#  finished               :boolean          default(FALSE)
#  project_id             :integer
#  due_date               :date
#

Fabricator(:task) do
  project         { Fabricate(:project) }
  start_date      { 1.days.since }
  due_date        { 3.days.since }
  accepted true
end
