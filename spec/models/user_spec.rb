require 'spec_helper'

describe User do
  before :each do
    @user  = Fabricate(:user)
  end

  it "is valid from the Fabric" do
    expect(@user).to be_valid
  end

  it "a user can have many tasks" do
    @task = Fabricate(:task)
    @task2 = Fabricate(:task)
    @user.tasks << @task
    @user.tasks << @task2
    expect(@user.tasks).to include(@task, @task2)
  end

  describe 'project_departments' do
    before do
      @service = Fabricate(:department, title: 'Service')
      @support = Fabricate(:department, title: 'Support')
      @service_project = Fabricate(:project, user: @user, department: @service)
      @support_project = Fabricate(:project, user: @user, department: @support)
    end

    it 'returns the departments from all projects that the user owns' do
      @user.project_departments.should eq [@service, @support]
    end
    
  end  

end
