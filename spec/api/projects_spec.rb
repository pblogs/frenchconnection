require 'spec_helper'

describe V1::Projects do

  describe 'GET /api/v1/projects/:id' do
    it 'get a project' do
      project = Fabricate(:project, name: 'New fence')
      get "/api/v1/projects/#{ project.id }"
      response.status.should == 200
      hash = JSON.parse(response.body)
      hash['projects']['name'].should eq 'New fence'
    end
  end

  describe 'GET /api/v1/projects/:id/tasks' do
    it 'get tasks belonging to a project' do
      project = Fabricate(:project)
      task = Fabricate(:task, project: project, description: 'Task 1')
      task = Fabricate(:task, project: project, description: 'Task 2')
      get "/api/v1/projects/#{ project.id }/tasks"
      hash = JSON.parse(response.body)
      hash['projects'].first['description'].should eq 'Task 1'
      hash['projects'].last['description'].should eq 'Task 2'
    end
  end

end
