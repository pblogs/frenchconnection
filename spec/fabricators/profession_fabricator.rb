# == Schema Information
#
# Table name: professions
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:profession) do
  title "MyString"
end
