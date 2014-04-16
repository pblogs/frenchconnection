require 'spec_helper'

describe ExcelProjectTools do

  before do
    @project = Fabricate(:project)
    @artisan = Fabricate(:artisan)
    @task    = Fabricate(:task, project: @project)
    @artisan.tasks << @task

    @hours_spent = Fabricate(:hours_spent, hour: 83, task: @task,
                             artisan: @artisan )
  end

  it %q{returns a comma separated 
  string with the sum of the hours each artisan has worked} do
    
    ExcelProjectTools.hours_for_artisans(@project).should eq "83"

  end
end
