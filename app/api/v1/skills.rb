module V1
  class Skills < Base

    resource :skills do
      
      desc "A user's skills"
      get ':user_id' do
        user = User.find(params[:user_id])
        skills = user.skills
        
        present :skills, skills, with: V1::Entities::Skills
        header 'Access-Control-Allow-Origin', '*'
      end

    end
  end
end
