# == Schema Information
#
# Table name: monthly_reports
#
#  id         :integer          not null, primary key
#  report     :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:monthly_report) do
  report  "MyString"
  user_id 1
end
