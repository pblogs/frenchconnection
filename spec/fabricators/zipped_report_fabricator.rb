# == Schema Information
#
# Table name: zipped_reports
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  zipfile     :string
#  created_at  :datetime
#  updated_at  :datetime
#  report_type :string
#

Fabricator(:zipped_report) do
  project { Fabricate :project }
  report_type { ZippedReport.report_type_enum.shuffle.first.last }
end
