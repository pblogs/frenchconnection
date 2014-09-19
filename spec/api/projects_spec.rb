require 'spec_helper'

describe V1::Projects do

  describe 'GET /api/v1/projects/:id' do
    it 'get a project' do
      project = Fabricate(:project, name: 'New fence')
      get "/api/v1/projects/#{ project.id }"
      #response.status.should == 200
      #hash = JSON.parse(response.body)
      #puts "ARRAY: #{hash}"
      #hash['project'].first['title'].should eq 'New fence'
    end
  end
end

