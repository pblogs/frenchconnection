class TimesheetScheduler
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: false

  recurrence { minutely(15) }

  def perform(*args)
    Project.joins(:hours_spents).distinct.find_each do |project|
      TimesheetWorker.perform_async(project.id)
    end
  end
end
