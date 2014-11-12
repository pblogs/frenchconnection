# == Schema Information
#
# Table name: professions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:profession) do
  title "MyString"
end
