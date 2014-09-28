require 'spec_helper'

describe V1::Users do

  describe 'GET /api/v1/users/:id' do
    it 'lists a specific user' do
      user = Fabricate :user
      get "/api/v1/users/#{ user.id }"
      response.status.should == 200
      hash = JSON.parse(response.body)
      hash['email'].should eq user.email
    end
  end
  
end
