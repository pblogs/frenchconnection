# == Schema Information
#
# Table name: attachments
#
#  id          :integer          not null, primary key
#  document    :string(255)
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  task_id     :integer
#

Fabricator(:attachment) do
  document "MyString"
end
