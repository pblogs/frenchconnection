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
#  default                              :boolean          default(FALSE)
#  project_reference                    :string
#

Fabricator(:project) do
  customer        { Fabricate(:customer) }
  department      { Fabricate(:department) }
  description    "Lag en ny port ved innkjøringen til parkeringen "
  due_date       { Time.now.next_week }
  execution_address { Faker::Address.street_address }
  name           { Faker::Company.name }
  default        { false }
  start_date     { Time.now }
  project_number { Random.new_seed.to_s[0,4] }
  user           { Fabricate(:user) }
end
