module V1
  class Users < Base

    resource :users do
      
      desc "All users with worker role"
      get 'workers' do
        workers = User.select { |user| user.roles.include? 'worker' }
        #present :users, workers, with: V1::Entities::Users
        present :users, workers
        header 'Access-Control-Allow-Origin', '*'
      end

      desc "One user"
      params do
        requires :user_id, type: Integer, desc: "User id."
      end
      route_param :user_id do
        get do
          user = User.find(params[:user_id])
          #present :user, user, with: V1::Entities::Users
          present :user, user
          header 'Access-Control-Allow-Origin', '*'
        end
      end
      
    end
  end
end
