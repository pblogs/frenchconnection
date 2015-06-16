# == Schema Information
#
# Table name: projects
#
#  id                                   :integer          not null, primary key
#  project_number                       :string
#  name                                 :string
#  created_at                           :datetime
#  updated_at                           :datetime
#  customer_id                          :integer
#  start_date                           :date
#  due_date                             :date
#  description                          :text
#  user_id                              :integer
#  execution_address                    :string
#  customer_reference                   :text
#  comment                              :text
#  sms_employee_if_hours_not_registered :boolean          default(FALSE)
#  sms_employee_when_new_task_created   :boolean          default(FALSE)
#  department_id                        :integer
#  complete                             :boolean          default(FALSE)
#

Fabricator(:project) do
  project_number "PL1"
  name           { Faker::Company.name }
  customer       { Fabricate(:customer) }
  start_date     { Time.now }
  due_date       { Time.now.next_week }
  description    "Lag en ny port ved innkjøringen til parkeringen "
  department      { Fabricate(:department) }
end
