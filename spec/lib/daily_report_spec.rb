require 'spec_helper'

describe DailyReport do

  before do
    @project = Fabricate(:project)
    @user    = Fabricate(:user, first_name: 'John')
    @task    = Fabricate(:task, project: @project)
    @profession = Fabricate(:profession, title: 'Snekker')
    @overtime = 50

    Fabricate(:hours_spent, hour: 10,        
               task: @task, user: @user )
    Fabricate(:hours_spent, overtime_50: 50, 
                         task: @task, user: @user )
  end

  it 'has no syntax errors' do
    DailyReport.new(project: @project, profession: @profession, overtime: 100,
                   of_kind: :billable).create_spreadsheet.class.should eq String
  end


end
