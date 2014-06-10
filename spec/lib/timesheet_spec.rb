require 'spec_helper'

describe Timesheet do

  before do
    @project = Fabricate(:project)
    @user = Fabricate(:user, first_name: 'John')
    @task    = Fabricate(:task, project: @project)
    @user.tasks << @task

    @hours = []
    @hours << Fabricate(:hours_spent, hour: 10,        task: @task, user: @user )
    @hours << Fabricate(:hours_spent, overtime_50: 50, task: @task, user: @user )
  end

  it 'has no syntax errors' do
    Timesheet.new(@project, @user, @hours).create_spreadsheet.class.should eq String
  end

  #it %q{returns a comma separated 
  #string with the sum of the hours each user has worked} do
  #  ExcelProjectTools.hours_for_users(@project).should eq ['20','19']
  #end

  #it %q{returns a comma separated string of names} do
  #  ExcelProjectTools.user_names(@project).should eq ['John',' Ali']
  #end


end
