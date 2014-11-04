class ProjectReportsController < ApplicationController

  def show
    report = ZippedReport.find(params[:id])
    send_data report.zipfile.read,
              filename: File.basename(report.zipfile.path)
  end

  def create
    case type = params[:type]
      when 'daily_report', 'timesheet'
        worker = "#{type.camelize}Worker".constantize
        @token = SecureRandom::uuid
        worker.perform_in(5.seconds.since, params[:project_id], current_user.id, @token)
      else
        raise "Invalid report type: #{type}"
    end
  end

end
