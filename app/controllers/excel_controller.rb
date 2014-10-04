class ExcelController < ApplicationController
  skip_before_filter :authenticate_user!
  layout :resolve_layout
  
  def dagsrapport
    @project    = Project.find(params[:project_id])
    @profession = Profession.find(params[:profession_id])
    @workers    = @project.users_with_profession(profession: @profession)
    @overtime   = params[:overtime]
    @filename   = Dagsrapport.new(project: @project, profession: @profession, 
                                 overtime: @overtime).create_spreadsheet
    respond_to do |format|
      format.pdf do
        filename = generate_dagsrapport_pdf(profession_title: @profession.title,
                                           overtime: @overtime)
        send_file filename, filename: File.basename(filename)
      end
      format.html do
        @hours_spent = @project.hours_spent_for_profession(@profession, 
                                                           overtime: @overtime)
        render 'dagsrapport-table'
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
    filename = Timesheet.new(@project, @user, 
                              @hours).create_spreadsheet
    send_file filename, filename:  filename
  end



  private

  
  def generate_dagsrapport_pdf(profession_title:, overtime:)
    filename = "/tmp/dagsrapport-#{profession_title.downcase}-#{overtime}.pdf"
    url  = request.original_url.gsub('.pdf', '')
    kit  = PDFKit.new(url)
    kit.to_file(filename)
    filename
  end

  def offsett(nr)
    r = []
    nr.times do 
      r << ''
    end
    r
  end

  def resolve_layout
    case action_name
    when 'dagsrapport'
      'excel'
    when 'timesheet'
      'excel'
    else
      'application'
    end
  end

end
