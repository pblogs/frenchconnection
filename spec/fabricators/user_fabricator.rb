# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           not null
#  roles                  :string           is an Array
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  department_id          :integer
#  mobile                 :integer
#  employee_nr            :string
#  image                  :string
#  emp_id                 :string
#  profession_id          :integer
#  home_address           :string
#  home_area_code         :string
#  home_area              :string
#  roles_mask             :integer
#  gender                 :string
#  address                :string
#  birth_date             :date
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
