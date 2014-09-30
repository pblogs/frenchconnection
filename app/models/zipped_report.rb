class ZippedReport < ActiveRecord::Base
  mount_uploader :zipfile, ZipfileUploader

  belongs_to :project

  symbolize :report_type, in: %i(timesheet daily_report)

  scope :timesheets, -> { where report_type: :timesheet }
  scope :daily_reports, -> { where report_type: :daily_report }

end
