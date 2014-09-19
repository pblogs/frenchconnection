module V1
  class Projects < Base

    resource :projects do

      params do
        requires :id, type: Integer, desc: "Project id."
      end
      route_param :id do
        get do
          p = Project.find(params[:id])
          present :projects, p, with: V1::Entities::Projects
        end
      end
    end

  end
end
