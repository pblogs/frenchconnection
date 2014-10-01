module V1
  class Tasks < Base

    resource :tasks do
      
      desc "Confirm user_task"
      params do
        requires :task_id, type: Integer, desc: "Task id."
      end
      route_param :task_id do
        options 'users/:user_id/confirm_user_task' do
          header 'Access-Control-Allow-Headers', 'Content-Type'
          header 'Access-Control-Allow-Origin', '*'
        end   
        post 'users/:user_id/confirm_user_task' do
          if user_task = UserTask
                         .where(user_id: params[:user_id], 
                            task_id: params[:task_id])
                         .first_or_create(user_id: params[:user_id],
                            task_id: params[:task_id])
                                        
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
      get 'unconfirmed/:user_id' do
        u = User.find(params[:user_id])
        unconfirmed_tasks = 
          u.user_tasks.where(status: :pending)
          .collect { |user_task| user_task.task }
        
        present :tasks, unconfirmed_tasks, with: V1::Entities::Tasks
        header 'Access-Control-Allow-Origin', '*'
      end
      
      desc "confirmed_tasks"
      get 'confirmed/:user_id' do
        u = User.find(params[:user_id])
        confirmed_tasks = 
          u.user_tasks.where(status: :confirmed)
          .collect { |user_task| user_task.task }
        
        present :tasks, confirmed_tasks, with: V1::Entities::Tasks
        header 'Access-Control-Allow-Origin', '*'
      end
      
      desc "Tasks not connected to user"
      get 'available/:user_id' do
        user = User.find(params[:user_id])
        all_tasks = Task.all
        unconnected_tasks = 
          all_tasks.reject { |task| user.tasks.include? task }
        
        present :tasks, unconnected_tasks, with: V1::Entities::Tasks
        header 'Access-Control-Allow-Origin', '*'
      end

    end
  end
end