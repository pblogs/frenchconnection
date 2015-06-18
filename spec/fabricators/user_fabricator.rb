# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  encrypted_password     :string(255)      not null
#  roles                  :string           is an Array
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  department_id          :integer
#  mobile                 :integer
#  employee_nr            :string(255)
#  image                  :string(255)
#  emp_id                 :string(255)
#  profession_id          :integer
#  home_address           :string(255)
#  home_area_code         :string(255)
#  home_area              :string(255)
#  roles_mask             :integer
#

Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  email      { Faker::Internet.email }
  mobile     { Faker::Base.numerify('########') }
  password   { 'topsecret' }
  password_confirmation { 'topsecret' }
  department { Fabricate(:department) }
  emp_id     { Random.rand(1100) }
  roles      [:worker]
end
