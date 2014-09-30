class ProjectReportsController < ApplicationController
  def daily_report
    project = Project.find(params[:id])
    if report = project.last_daily_report
      send_data report.zipfile.read,
                filename: File.basename(report.zipfile.path)
    else
      render text: "Report not ready"
    end
  end

  def timesheet
    project = Project.find(params[:id])
    if report = project.last_timesheet
      send_data report.zipfile.read,
                filename: File.basename(report.zipfile.path)
    else
      render text: "Report not ready"
    end
  end
end
