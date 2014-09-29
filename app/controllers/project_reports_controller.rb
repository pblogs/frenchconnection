class ProjectReportsController < ApplicationController
  def daily_report
    project = Project.find(params[:id])
    if report = ZippedReport.daily_reports.where(project: project).order(:created_at).last
      send_data report.zipfile.read,
                filename: File.basename(report.zipfile.path)
    else
      render text: "Report not ready"
    end
  end

  def timesheet
    project = Project.find(params[:id])
    if report = ZippedReport.timesheets.where(project: project).order(:created_at).last
      send_data report.zipfile.read,
                filename: File.basename(report.zipfile.path)
    else
      render text: "Report not ready"
    end
  end
end
