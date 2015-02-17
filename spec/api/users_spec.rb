require 'spec_helper'

describe V1::Users do
  before do
    User.destroy_all
    @worker = Fabricate(:user, id: 1, roles: [:worker])
    Fabricate(:user, id: 2, roles: [:worker])
    Fabricate(:user, id: 3, roles: [:worker, :project_leader])
    Fabricate(:user, id: 4, roles: [:project_leader])
  end
  
  describe 'GET /api/v1/users/workers' do
    it 'lists all workers' do
      get "/api/v1/users/workers"
      response.status.should == 200
      hash = JSON.parse(response.body)
      worker_ids = hash['users'].collect { |u| u['id'] }
      worker_ids.should =~ [1,2,3] 
    end
  end

  describe 'GET /api/v1/users/id/:user_id' do
    it 'lists a specific user' do
      get "/api/v1/users/#{ @worker.id }"
      response.status.should == 200
      hash = JSON.parse(response.body)
      u = hash['user']
      u['email'].should eq @worker.email
    end
  end

  describe 'GET /api/v1/users/id/timesheets' do
    before do
      MonthlyReport.create(user_id: @worker.id, month_nr: 6, title: 'Slottet')
    end
    it 'returns a list of timesheets for the current month' do
      get "/api/v1/users/#{ @worker.id }/timesheets"
      response.status.should == 200
      hash = JSON.parse(response.body)
      # { '6' => [ {:title=>"Slottet", :url=>"http://example.pdf"} ]  }
      hash["6"].first["title"].should eq 'Slottet'
    end
  end
  
end
