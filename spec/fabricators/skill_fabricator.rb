# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:skill) do
  title     { Faker::Lorem.word }
end
