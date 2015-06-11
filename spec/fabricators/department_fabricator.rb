# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:department) do
  title  { "Department #{ Random.rand(1100) } - #{ Random.rand(1100)} " }
end
