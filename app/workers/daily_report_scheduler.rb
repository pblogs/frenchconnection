class DailyReportScheduler
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: false

  recurrence { minutely(15) }

  def perform(*args)
    Project.find_each do |project|
      DailyReportWorker.perform_async(project.id)
    end
  end
end