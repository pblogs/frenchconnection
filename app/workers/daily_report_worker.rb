class DailyReportWorker
  include Sidekiq::Worker
  delegate :url_helpers, to: 'Rails.application.routes'

  sidekiq_options retry: false

  TYPES = %w(hour overtime_50 overtime_100 runs_in_company_car)

  ReportFile = Struct.new(:file, :profession, :type) do
    def filename
      "#{profession.title}-#{type}.pdf"
    end
  end

  def perform(project_id)
    @project = Project.find(project_id)

    begin

      Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
        files.each do |f|
          zipfile.add(f.filename, f.file.path)
        end
      end

      ZippedReport.daily_reports.create(project: @project, 
                                        zipfile: File.open(zipfile_path))

    ensure
      files.each { |f| f.file.unlink }
    end
  end

  private

  def files
    @files ||= @project.professions.compact.inject([]) do |files, p|
      files += TYPES.map do |type|
        generate_daily_report(@project, p, type)
      end
      files
    end
  end

  def generate_daily_report(project, profession, type)
    file = Tempfile.new self.class.to_s
    url = url_helpers.dagsrapport_url(
        project.id, profession.id, type, host: host)
    kit = PDFKit.new(url)
    kit.to_pdf(file.path)
    file.close
    ReportFile.new(file, profession, type)
  end

  def zipfile_path
    @zipfile_path ||=
        "/tmp/project-#{ @project.id }-daily-report-#{ timestamp }.zip"
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
