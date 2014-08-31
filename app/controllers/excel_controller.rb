class ExcelController < ApplicationController
  layout :resolve_layout
  
  def dagsrapport
    @project    = Project.find(params[:project_id])
    @profession = Profession.find(params[:profession_id])
    overtime    = params[:overtime]
    file_name   = Dagsrapport.new(@project, profession, 
                                 overtime).create_spreadsheet
    send_file file_name,
      filename:  "dagsrapport.xls"
  end

  def timesheets
    @customers = Customer.all
  end

  def timesheet
    @project = Project.find(params[:project_id])
    @user    = User.find(params[:user_id])
    @hours   = @project.hours_spents.where(user: @user).all
    file_name = Timesheet.new(@project, @user, 
                              @hours).create_spreadsheet
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
