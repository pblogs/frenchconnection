require 'spec_helper'

describe Timesheet, focus: true do

  before do
    @project = Fabricate(:project)
    @user = Fabricate(:user, first_name: 'John')
    @task    = Fabricate(:task, project: @project)
    @user.tasks << @task

    @hours = []
    @hours << Fabricate(:hours_spent, hour: 10,        
                         task: @task, user: @user )
    @hours << Fabricate(:hours_spent, overtime_50: 50, 
                         task: @task, user: @user )
  end

  it 'has no syntax errors' do
    pending "Fails at CC"
    Timesheet.new(@project, @user, @hours)
      .create_spreadsheet.class.should eq String
  end


end
