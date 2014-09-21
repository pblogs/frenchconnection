class CompleteProjectWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    project.users.workers.each do |worker|
      Sms.send_msg(worker.mobile, I18n.t('sms.complete_project', project_name: project.name))
    end
  end

end
