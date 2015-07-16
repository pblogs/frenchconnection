# == Schema Information
#
# Table name: kids
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string
#  birth_date   :date
#  sole_custody :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

Fabricator(:kid) do
  user         { Fabricate(:user) }
  name         { Faker::Name.first_name }
  birth_date   "2015-07-16"
  sole_custody false
end
