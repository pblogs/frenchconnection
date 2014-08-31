require 'spec_helper'

describe ExcelProjectTools do

  before do
    @project = Fabricate(:project)
    @department = Fabricate(:department)
    @user1 = Fabricate(:user, first_name: 'John', last_name: 'Jonassen', department: @department, emp_id: "12121", roles: ["project_leader"])
    @user2 = Fabricate(:user, first_name: 'Ali', last_name: 'Jonassen', department: @department, emp_id: "12121", roles: ["project_leader"])
    @task    = Fabricate(:task, project: @project)
    @user1.tasks << @task
    @user2.tasks << @task

    Fabricate(:hours_spent, hour: 10, task: @task, user: @user1 )
    Fabricate(:hours_spent, hour: 10, task: @task, user: @user1 )
    Fabricate(:hours_spent, hour: 19, task: @task, user: @user2 )
  end

  it %q{returns a comma separated 
  string with the sum of the hours each user has worked} do
    ExcelProjectTools.hours_for_users(@project).should eq ['20','19']
  end

  it %q{returns a comma separated string of names} do
    ExcelProjectTools.user_names(@project).should eq ['John',' Ali']
  end


end
