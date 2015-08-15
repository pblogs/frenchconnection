# == Schema Information
#
# Table name: monthly_reports
#
#  id         :integer          not null, primary key
#  document   :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  month_nr   :integer
#  title      :string
#  year       :integer
#

Fabricator(:monthly_report) do
  report  "MyString"
  user_id 1
end
