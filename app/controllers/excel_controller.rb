class ExcelController < ApplicationController
  skip_before_filter :authenticate_user!
  layout :resolve_layout
  
  def daily_report
    @project    = Project.find(params[:project_id])
    @profession = Profession.find(params[:profession_id])
    @workers    = @project.users_with_profession(profession: @profession)
    @overtime   = params[:overtime]
    @filename   = DailyReport.new(project: @project, profession: @profession, 
                                 overtime: @overtime).create_spreadsheet
    @week_numbers = @project.week_numbers(profession: @profession)

    respond_to do |format|
      format.pdf do
        filename = generate_daily_report_pdf(profession_title: @profession.title,
                                             overtime: @overtime)
        send_file filename, filename: File.basename(filename)
      end
      format.html do
        @hours_spent = @project.hours_spent_for_profession(@profession, 
                                                           overtime: @overtime)
        render 'daily_report-table'
      end
    end
  end

  def weekly_report
    @project    = Project.find(params[:project_id])
    @workers    = @project.users
    @overtime   = params[:overtime]
    @filename   = WeeklyReport.new(project: @project, profession: @profession, 
                                   overtime: @overtime).create_spreadsheet
    respond_to do |format|
      format.pdf do
        filename = generate_daily_report_pdf(profession_title: @profession.title,
                                             overtime: @overtime)
        send_file filename, filename: File.basename(filename)
      end
      format.html do
        @hours_spent = @project.hours_spent_for_profession(@profession, 
                                                           overtime: @overtime)
        render 'daily_report-table'
      end
    end
  end

  def monthly_report
    if Date::MONTHNAMES[params[:month].to_i]
      @project =  Project.find(params[:project_id])
      @month =  params[:month]
      @year =  params[:year]
      overtime   = params[:overtime]
      @monthly_report, @total_weeks =  @project.generate_monthly_report(@year, @month, overtime)

      respond_to do |format|
        format.pdf do
          filename = generate_monthly_report_pdf(@project.name)
          send_file filename, filename: File.basename(filename)
        end
        format.html do
          render 'monthly_report'
        end
      end
    else
      redirect_to root_path, alert: "Please Enter a Valid Month Number."
    end
  end

  def timesheets
    @customers = Customer.all
  end

  
  # The timesheet is given to the customers HR department. It's used for
  # calucation sallery for the workers.
  # From and to date: Use the date from the first HoursSpent and the last.
  def timesheet
    @project = Project.find(params[:project_id])
    @user    = User.find(params[:user_id])
    @hours   = @project.hours_spents.where(user: @user).all
    filename = Timesheet.new(@project, @user, 
                              @hours).create_spreadsheet
    send_file filename, filename:  filename
  end

  private
  
  def generate_daily_report_pdf(profession_title:, overtime:)
    filename = "/tmp/daily_report-#{profession_title.downcase}-#{overtime}.pdf"
    url  = request.original_url.gsub('.pdf', '')
    kit  = PDFKit.new(url)
    kit.to_file(filename)
    filename
  end

  #######
  ## Copied from the daily report action. Its not working locally
  #######
  def generate_monthly_report_pdf(project_name)
    filename = "/tmp/monthly_report-#{project_name.downcase}.pdf"
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
    when 'daily_report', 'monthly_report'
      'excel'
    when 'timesheet'
      'excel'
    else
      'application'
    end
  end

end
