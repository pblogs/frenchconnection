require 'spec_helper'

describe Dagsrapport do

  before do
    @project = Fabricate(:project)
    @user    = Fabricate(:user, first_name: 'John')
    @task    = Fabricate(:task, project: @project)

    Fabricate(:hours_spent, hour: 10,        
               task: @task, user: @user )
    Fabricate(:hours_spent, overtime_50: 50, 
                         task: @task, user: @user )
  end

  it 'has no syntax errors' do
    Dagsrapport.new(@project)
      .create_spreadsheet.class.should eq String
  end


end
