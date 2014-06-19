module V1
  class Person < Grape::API
    before { restrict_access! }
    version 'v1', using: :path, vendor: 'martin', cascade: false

    helpers do
      include ApiHelpers

      #def permitted_params
      #  request_params = ActionController::Parameters.new(params)
      #  request_params.require(:user).permit(:full_name, :email, :password)
      #end
    end

    format :json
    desc 'Returns pong.'
    get :user do
      'hi'
    end
  end
end
