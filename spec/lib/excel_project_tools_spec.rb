require 'spec_helper'

describe ExcelProjectTools do

  before do
    @project = Fabricate(:project)
    @artisan1 = Fabricate(:artisan)
    @artisan2 = Fabricate(:artisan)
    @task    = Fabricate(:task, project: @project)
    @artisan1.tasks << @task
    @artisan2.tasks << @task

    Fabricate(:hours_spent, hour: 83, task: @task, artisan: @artisan1 )
    Fabricate(:hours_spent, hour: 19, task: @task, artisan: @artisan2 )
  end

  it %q{returns a comma separated 
  string with the sum of the hours each artisan has worked} do
    
    ExcelProjectTools.hours_for_artisans(@project).should eq ['83','19']

  end
end
