module V1
  class MobilePictures < Base

    resource :mobile_pictures do
      
      desc "Create MobilePicture by user on task"
      options 'users/:user_id/tasks/:task_id' do
        header 'Access-Control-Allow-Headers', 'Content-Type'
        header 'Access-Control-Allow-Origin', '*'
      end
      
      post 'users/:user_id/tasks/:task_id' do
        request_params = ActionController::Parameters.new(params)
        permitted_params = 
          request_params.permit(:user_id, :task_id, :url, :description)
        
        if mobile_picture = MobilePicture.create(permitted_params)
          mobile_picture.project_id = 
            Task.find(mobile_picture.task_id).project_id
          mobile_picture.save!
          present mobile_picture.id
          header 'Access-Control-Allow-Origin', '*'
        else
          error! mobile_picture.errors, 400
          header 'Access-Control-Allow-Origin', '*'
        end
      end
      
      desc "MobilePictures by user on task"
      get 'users/:user_id/tasks/:task_id' do
        user = User.find(params[:user_id])
        task_id = params[:task_id].to_i
        mobile_pictures_on_task = 
          MobilePicture.all.select { 
            |mp| mp.task_id == task_id && mp.user_id == user.id 
          }
          
        present :mobile_pictures, 
                mobile_pictures_on_task, 
                with: V1::Entities::MobilePictures
        
        header 'Access-Control-Allow-Origin', '*'
      end
      
    end
    
  end
end
