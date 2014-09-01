require 'spec_helper'

describe ExcelProjectTools do

  before do
    @project = Fabricate(:project)
    @user1 = Fabricate(:user, first_name: 'John')
    @snekker_jens = Fabricate(:user, first_name: 'Snekker Jens', profession: Fabricate(:profession, title: 'Snekker'))
    @task    = Fabricate(:task, project: @project)
    @user1.tasks << @task
    @snekker_jens.tasks << @task

    Fabricate(:hours_spent, hour: 10, task: @task, user: @user1 )
    Fabricate(:hours_spent, hour: 10, task: @task, user: @user1 )
    Fabricate(:hours_spent, hour: 19, task: @task, user: @snekker_jens )
  end

  it %q{returns a comma separated 
  string with the sum of the hours each user has worked} do
    snekker = Profession.where(title: 'Snekker')
    ExcelProjectTools.hours_for_users(project: @project, profession: snekker).should eq ['19']
  end

  it %q{returns a comma separated string of names} do
    ExcelProjectTools.user_names(project: @project).should eq ['John',' Snekker Jens']
  end

  it %q{returns a comma separated string of names for profession} do
    ExcelProjectTools.user_names(project: @project, 
                                 profession_title: 'Snekker').should eq ['Snekker Jens']
  end

end
