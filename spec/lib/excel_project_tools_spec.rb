require 'spec_helper'

describe ExcelProjectTools do

  before do
    @project = Fabricate(:project)
    @artisan1 = Fabricate(:artisan, name: 'John')
    @artisan2 = Fabricate(:artisan, name: 'Ali')
    @task    = Fabricate(:task, project: @project)
    @artisan1.tasks << @task
    @artisan2.tasks << @task

    Fabricate(:hours_spent, hour: 10, task: @task, artisan: @artisan1 )
    Fabricate(:hours_spent, hour: 10, task: @task, artisan: @artisan1 )
    Fabricate(:hours_spent, hour: 19, task: @task, artisan: @artisan2 )
  end

  it %q{returns a comma separated 
  string with the sum of the hours each artisan has worked} do
    ExcelProjectTools.hours_for_artisans(@project).should eq ['20','19']
  end

  it %q{returns a comma separated string of names} do
    ExcelProjectTools.artisan_names(@project).should eq ['John',' Ali']
  end


end
