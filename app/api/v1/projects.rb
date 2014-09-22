module V1
  class Projects < Base

    resource :projects do
      
      desc "all projects"
      get do
        projects = Project.all
        present :projects, projects, with: V1::Entities::Projects
        header 'Access-Control-Allow-Origin', '*'
      end

      params do
        requires :id, type: Integer, desc: "Project id."
      end
      route_param :id do
        get do
          p = Project.find(params[:id])
          present :projects, p, with: V1::Entities::Projects
        end
      end

      desc "Get tasks belonging to a project"
      params do
        requires :id, type: Integer, desc: "Project id."
      end
      route_param :id do
        get 'tasks' do
          p = Project.find(params[:id])
          present :projects, p.tasks.all, with: V1::Entities::Tasks
        end
      end

    end

  end
end
