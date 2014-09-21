class CompleteProjectWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    project.users.workers.each do |worker|
      Sms.send_msg(worker.mobile, <<-eos.gsub(/\s+/, " ").strip
        We're ending the #{project.name} project today.
        Make sure you've reported all billable hours within the day.
        Regards, your project leader
      eos
      )
    end
  end

end
