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
      
      desc "Confirm user_task"
      params do
        requires :user_id, type: Integer, desc: "User id."
      end
      route_param :user_id do
        options 'tasks/:task_id/confirm_user_task' do
          header 'Access-Control-Allow-Headers', 'Content-Type'
          header 'Access-Control-Allow-Origin', '*'
        end
        
        post 'tasks/:task_id/confirm_user_task' do
          if user_task = UserTask.where(user_id: params[:user_id], 
                                        task_id: params[:task_id]).first
                                        
            user_task.confirm!
            present user_task.id
            header 'Access-Control-Allow-Origin', '*'
          else
            error! 400
            header 'Access-Control-Allow-Origin', '*'
          end
        end
      end
      
      desc "unconfirmed_tasks"
      params do
        requires :id, type: Integer, desc: "User id."
      end
      route_param :id do
        get 'unconfirmed_tasks' do
          u = User.find(params[:id])
          unconfirmed_tasks = 
            u.user_tasks.where(status: :pending)
            .collect { |user_task| user_task.task }
          
          present :tasks, unconfirmed_tasks, with: V1::Entities::Tasks
          header 'Access-Control-Allow-Origin', '*'
        end
      end

      desc "confirmed_tasks"
      params do
        requires :id, type: Integer, desc: "User id."
      end
      route_param :id do
        get 'confirmed_tasks' do
          u = User.find(params[:id])
          confirmed_tasks = 
            u.user_tasks.where(status: :confirmed)
            .collect { |user_task| user_task.task }
          
          present :tasks, confirmed_tasks, with: V1::Entities::Tasks
          header 'Access-Control-Allow-Origin', '*'
        end
      end
      
      desc "Tasks not connected to user"
      params do
        requires :id, type: Integer, desc: "User id."
      end
      route_param :id do
        get 'available_tasks' do
          user = User.find(params[:id])
          all_tasks = Task.all
          unconnected_tasks = 
            all_tasks.reject { |task| user.tasks.include? task }
          
          present :tasks, unconnected_tasks, with: V1::Entities::Tasks
          header 'Access-Control-Allow-Origin', '*'
        end
      end
      
      
      desc "HoursSpents by user"
      params do
        requires :id, type: Integer, desc: "User id."
      end
      route_param :id do
        get 'hours_spents' do
          user = User.find(params[:id])
          hours_spents = user.hours_spents
          present :hours_spents, hours_spents, with: V1::Entities::HoursSpents
          header 'Access-Control-Allow-Origin', '*'
        end
      end
      
      desc "HoursSpents by user on task"
      params do
        requires :user_id, type: Integer, desc: "User id."
      end
      route_param :user_id do
        get 'tasks/:task_id/hours_spents' do
          user = User.find(params[:user_id])
          task_id = params[:task_id].to_i
          hours_spents_on_task = 
            user.hours_spents.select { 
              |hour_spent| hour_spent.task_id == task_id }
            
          present :hours_spents, 
                  hours_spents_on_task, 
                  with: V1::Entities::HoursSpents
          
          header 'Access-Control-Allow-Origin', '*'
        end
      end
      
      desc "HoursSpents by user on task on date"
      params do
        requires :user_id, type: Integer, desc: "User id."
      end
      route_param :user_id do
        get 'tasks/:task_id/hours_spents/:date' do
          user = User.find(params[:user_id])
          task_id = params[:task_id].to_i
          date = params[:date]
          hours_spents_on_task_on_date = 
            user.hours_spents.select { 
              |hour_spent|  hour_spent.task_id == task_id && 
                            hour_spent.date.to_s == date }
              
          present :hours_spents, 
                  hours_spents_on_task_on_date, 
                  with: V1::Entities::HoursSpents
          
          header 'Access-Control-Allow-Origin', '*'
        end
      end
      
      desc "Create HoursSpents by user on task on date"
      params do
        requires :user_id, type: Integer, desc: "User id."
      end
      route_param :user_id do
        options 'tasks/:task_id/hours_spents/:date' do
          header 'Access-Control-Allow-Headers', 'Content-Type'
          header 'Access-Control-Allow-Origin', '*'
        end
        
        post 'tasks/:task_id/hours_spents/:date' do
          request_params = ActionController::Parameters.new(params)
          permitted_params = request_params.permit(:user_id, :task_id, :date,
            :hour, :overtime_50, :overtime_100, :description,
            :runs_in_company_car, :km_driven_own_car, :toll_expenses_own_car,
            :supplies_from_warehouse)
          
          if hours_spent = HoursSpent.create(permitted_params)
            hours_spent.project_id = Task.find(hours_spent.task_id).project_id
            hours_spent.save!
            present hours_spent.id
            header 'Access-Control-Allow-Origin', '*'
          else
            error! hours_spent.errors, 400
            header 'Access-Control-Allow-Origin', '*'
          end

        end
      end

      params { requires :id }
      route_param :id do
        get do
          user = User.find(params[:id])
          present :user, user, with: V1::Entities::Users
        end
      end

      #desc 'Get the newest 25 users regardless of location'
      #get 'recent' do
      #  cache key: "api-v1-users-recent", expires_in: 10.minutes do
      #    users = Ad.latest.limit(25)
      #    present :users, users, with: V1::Entities::Users
      #  end
      #end

      #desc 'Retreive all users or search by query'
      #params do
      #  use :requires_coordinates, :optional_geo_range, :optional_pagination
      #end
      #get do
      #  query         = params[:query].present? ? params[:query] : nil
      #  page_nr       = Pagination.page_nr(params[:page])
      #  search_params = Search.build_query(query: query,
      #                    lat: params[:lat], lon: params[:lon],
      #                    from: params[:from], to: params[:to])

      #  users          = Ad.search(search_params).page(page_nr).records
      #  newest_first = users.sort_by{ |rec| rec[:created_at] }.reverse
      #  present :users, newest_first, with: V1::Entities::Users
      #end



      #desc 'Update existing user, applies only to the signed in user\'s users'
      #params do
      #  use :requires_user_id, :optional_user_attribs, :optional_coordinates
      #end
      #route_param :id do
      #  put do
      #    user = current_user.users.find(params[:id])
      #    if user.update(permitted_params)
      #      present :user, user, with: V1::Entities::Users
      #    else
      #      error! user.errors, 400
      #    end
      #  end
      #end

      #desc 'Change state of user, applies only to the signed in user\'s users'
      #params { use :requires_user_id, :requires_transition }
      #route_param :id do
      #  put 'event/:transition' do
      #    user = current_user.users.find(params[:id])
      #    if user.fire_state_event(params[:transition])
      #      present :user, user, with: V1::Entities::Users
      #    else
      #      error! user.errors, 400
      #    end
      #  end
      #end

      #desc 'Create new user'
      #params do
      #  use :requires_coordinates, :requires_user_attribs, :requires_prospect_image
      #end
      #post do
      #  attachment =  handle_image
      #  lat_lon = { lat: params[:lat], lon: params[:lon] }
      #  user = Ad.new(permitted_params.merge(
      #    user:        current_user,
      #    coordinates: lat_lon,
      #    prospect_image: attachment)
      #  )

      #  if user.save
      #    user.prospect_image.save
      #    present :user, user, with: V1::Entities::Users
      #  else
      #    error! user.errors, 400
      #  end
      #end

    end
  end
end
