module V1
  class User < Grape::API
    format :json
    desc 'Returns pong.'
    get :user do
      { ping: params[:pong] || 'pong' }
    end
  end
end
