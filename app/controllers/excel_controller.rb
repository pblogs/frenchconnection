class ExcelController < ApplicationController
  layout :resolve_layout
  
  require 'spreadsheet'

  def dagsrapport
    @project = Project.find(params[:project_id])
    file_name = Dagsrapport.new(@project).create_spreadsheet
    send_file file_name,
      filename:  "dagsrapport.xls"
  end

  def timesheets
    @projects = Project.all
  end

  def timesheet
    @project = Project.find(params[:project_id])
    @artisan = Artisan.find(params[:artisan_id])
    @hours   = @project.hours_spents.where(artisan: @artisan).all
    Rails.logger.debug  "hours is #{@hours.inspect}"
    file_name = Timesheet.new(@project, @artisan, @hours).create_spreadsheet
    send_file file_name,
      filename:  file_name
  end



  private

  def offsett(nr)
    r = []
    nr.times do 
      r << ''
    end
    r
  end

  def resolve_layout
    case action_name
    when 'html_export'
      'excel'
    else
      'application'
    end
    
  end

end
