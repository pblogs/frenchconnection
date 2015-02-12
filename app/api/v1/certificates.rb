module V1
  class Certificates < Base

    resource :certificates do
      
      desc "A user's certificates"
      get ':user_id' do
        user = User.find(params[:user_id])
        certs = user.certificates
        
        present :certificates, certs, with: V1::Entities::Certificates
        header 'Access-Control-Allow-Origin', '*'
      end

    end
  end
end
