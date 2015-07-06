# == Schema Information
#
# Table name: zipped_reports
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  zipfile     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  report_type :string(255)
#

class ZippedReport < ActiveRecord::Base
  mount_uploader :zipfile, ZipfileUploader

  belongs_to :project

  symbolize :report_type, in: %i(timesheet daily_report)

  scope :timesheets, -> { where report_type: :timesheet }
  scope :daily_reports, -> { where report_type: :daily_report }

  # Destroys all ZippedReports of the same type,
  # belonging to the same project, except this one.
  # It is supposed to keep only the newest report of each type
  # for given project.
  def cleanup_old_reports
    ZippedReport.where(report_type: report_type, project_id: project_id)
                .where("id != ?", id).destroy_all
  end

end
