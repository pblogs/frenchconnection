class TimesheetWorker
  include Sidekiq::Worker
  delegate :url_helpers, to: 'Rails.application.routes'

  sidekiq_options retry: false

  ReportFile = Struct.new(:file, :user, :type) do
    def filename
      "#{user.name.parameterize}.xls"
    end
  end

  def perform(project_id, user_id, token, month, year)
    @month = month
    @year  = year
    puts "\n\n DEBUG \n year: #{@year}, month: #{@month}"
    begin
      @project = Project.find(project_id)
      return unless @project

      Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
        files.each do |f|
          zipfile.add(f.filename, f.file)
        end
      end

      current = ZippedReport.timesheets.create(project: @project,
                                               zipfile: File.open(zipfile_path))
      #ZippedReportCleanerWorker.perform_in(15.minutes, current.id)

      Pusher["user-#{user_id}"].trigger("report", {
          id: current.id,
          token: token,
          url: url_helpers.project_report_path(current)
      })

      current

    rescue Exception => e
      Pusher["user-#{user_id}"].trigger("report", {
          id: current.try(:id),
          token: token,
          error: e
      })
      raise e
    end
  end

  private

  def files
    # TODO: Only iterate over users that has approved hours.
    @project.users.uniq.map do |u|
      generate_timesheet(@project, u)
    end
  end

  def generate_timesheet(project, user)
    hours = project.hours_spents.personal.approved.where(user: user).year(@year).month(@month)
    filename = Timesheet.new(project, user, hours, @month, @year).create_spreadsheet
    file = File.open(filename)
    user.monthly_reports.where(month_nr: @month, year: @year, title: project.name).destroy_all
    user.monthly_reports.create!(document: file, month_nr: @month, year: @year, title: project.name)
    ReportFile.new(filename, user)
  end

  def zipfile_path
    # project_number-adress-date
    @zipfile_path ||= 
      "/tmp/timesheet-#{@project.project_number}-"+
      "#{@project.address}-#{timestamp}.zip"
  end

  def timestamp
    DateTime.now.strftime '%Y-%m-%d-%H-%M'
  end

  def host
    unless domain = ENV['DOMAIN']
      Sidekiq.logger.warn "DOMAIN environment variable not set"
    end
    domain || 'localhost:3000'
  end
end
