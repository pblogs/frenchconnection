class CompleteProjectWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    project.users.workers.each do |worker|
      Sms.send_msg(worker.mobile, "TODO msg body")
    end
  end

end
