require 'spec_helper'

describe V1::Users do
  
  describe 'GET /api/v1/users/workers' do
    it 'lists all workers' do
      #pending 'test'
      user1 = Fabricate(:user, roles: [:worker])
      user2 = Fabricate(:user, roles: [:worker])
      user3 = Fabricate(:user, roles: [:worker, :project_leader])
      user4 = Fabricate(:user, roles: [:project_leader])
      get "/api/v1/users/workers"
      response.status.should == 200
      hash = JSON.parse(response.body)
      worker_ids = hash['users'].collect { |u| u['id'] }
      worker_ids.should =~ [user3.id, user2.id, user1.id] 
    end
  end

  describe 'GET /api/v1/users/id/:user_id' do
    it 'lists a specific user' do
      #pending 'test'
      user = Fabricate :user
      get "/api/v1/users/#{ user.id }"
      response.status.should == 200
      hash = JSON.parse(response.body)
      u = hash['user']
      u['email'].should eq user.email
    end
  end
  
end
