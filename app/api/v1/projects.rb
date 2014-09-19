module V1
  class Projects < Base

    resource :projects do

      params do
        requires :id, type: Integer, desc: "Projects id."
      end
      route_param :id do
        get do
          Project.find(params[:id])
        end
      end
    end

  end
end
