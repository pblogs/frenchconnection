# == Schema Information
#
# Table name: attachments
#
#  id          :integer          not null, primary key
#  document    :string
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

Fabricator(:attachment) do
  document "MyString"
end
