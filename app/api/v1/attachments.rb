module V1
  class Attachments < Base

    resource :attachments do
      
      desc "A project's attachments"
      get ':project_id' do
        project = Project.find(params[:project_id])
        attachments = Attachment.where(project_id: project.id)
        
        present :attachments, attachments, with: V1::Entities::Attachments
        header 'Access-Control-Allow-Origin', '*'
      end

    end
  end
end
