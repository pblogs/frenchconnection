class CompleteProjectWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    project.users.each do |worker|
      Sms.send_msg(to: "47#{worker.mobile}",
                   msg: I18n.t('sms.complete_project', 
                               project_name: (project.name rescue '-'),
                               project_leader: (project.user.name rescue '-')
                              )
                  )
    end
  end

end
