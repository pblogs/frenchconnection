module V1
  class HoursSpents < Base

    resource :hours_spents do
      
      desc "Create HoursSpents by user on task on date"
      options 'users/:user_id/tasks/:task_id/dates/:date' do
        header 'Access-Control-Allow-Headers', 'Content-Type'
        header 'Access-Control-Allow-Origin', '*'
      end
      
      post 'users/:user_id/tasks/:task_id/dates/:date' do
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
      
      desc "Update HoursSpents with given id"
      params do
        requires :hours_spent_id, type: Integer, desc: "HoursSpent id."
      end
      route_param :hours_spent_id do
        options do
          header 'Access-Control-Allow-Headers', 'Content-Type'
          header 'Access-Control-Allow-Methods', 'PUT'
          header 'Access-Control-Allow-Origin', '*'
        end
        put do
          hours_spent = HoursSpent.find(params[:hours_spent_id])
          
          request_params = ActionController::Parameters.new(params)
          permitted_params = request_params.permit(:hour, :overtime_50, 
            :overtime_100, :description, :runs_in_company_car, 
            :km_driven_own_car, :toll_expenses_own_car, 
            :supplies_from_warehouse)
          
          if hours_spent.update(permitted_params)
            present :hours_spent, hours_spent, with: V1::Entities::HoursSpents
            header 'Access-Control-Allow-Origin', '*'
          else
            error! hours_spent.errors, 400
            header 'Access-Control-Allow-Origin', '*'
          end
        end
      end
      
      desc "HoursSpents by user"
      get ':user_id' do
        user = User.find(params[:user_id])
        hours_spents = user.hours_spents
        present :hours_spents, hours_spents, with: V1::Entities::HoursSpents
        header 'Access-Control-Allow-Origin', '*'
      end
      
      desc "HoursSpents by user on task"
      get 'users/:user_id/tasks/:task_id' do
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
      
      desc "HoursSpents by user on task on date"
      get 'users/:user_id/tasks/:task_id/dates/:date' do
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
  end
end
