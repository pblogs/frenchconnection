class ExcelController < ApplicationController
  layout :resolve_layout
  
  def dagsrapport
    @project    = Project.find(params[:project_id])
    @profession = Profession.find(params[:profession_id])
    @workers    = @project.users_with_profession(profession: @profession)
    @overtime   = params[:overtime]
    @file_name  = Dagsrapport.new(project: @project, profession: @profession, 
                                 overtime: @overtime).create_spreadsheet
    respond_to do |format|
      #format.xls {  send_file(file_name, filename:  "dagsrapport.xls")  }
      format.pdf {  send_file(file_name, filename:  "dagsrapport.xls")  }
      format.html do
        @hours_spent = @project.hours_spent_for_profession(@profession, overtime: @overtime)
      end
    end
  end

  def timesheets
    @customers = Customer.all
  end

  ###############################
  #    Timelisten gis til lønn. Pr mnd pr ansatt pr prosjekt.  
  #    (rapporteres den 15 og ved månedsskiftet)
  #    Scope en hel måned.
  #    Fra dato og til dato: Bruk dato fra den første timen 
  #    registrert og dato på siste time registerert.
  #    prosjektnavnet må tas med i regnearket.
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
