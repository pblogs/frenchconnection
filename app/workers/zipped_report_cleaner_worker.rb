class ZippedReportCleanerWorker
  include Sidekiq::Worker

  def perform(zipped_report_id)
    ZippedReport.destroy zipped_report_id
  end
end