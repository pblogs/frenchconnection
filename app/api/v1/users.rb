module V1
  class Users < Base

    resource :users do

      params do
        requires :id, type: Integer, desc: "User id."
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end

      params { requires :id }
      route_param :id do
        get do
          user = User.find(params[:id])
          present :user, user, with: V1::Entities::Users
        end
      end
      
    end
  end
end
