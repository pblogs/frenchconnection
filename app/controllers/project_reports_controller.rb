class ProjectReportsController < ApplicationController
  def daily_report
    project = Project.find(params[:id])
    if report = ZippedReport.where(project: project).order(:created_at).last
      send_file report.zipfile.path
    else
      render text: "Report not ready"
    end
  end
end
