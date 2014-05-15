require 'spec_helper'

describe Timesheet do

  before do
    @project = Fabricate(:project)
    @artisan = Fabricate(:artisan, name: 'John')
    @task    = Fabricate(:task, project: @project)
    @artisan.tasks << @task

    @hours = []
    @hours << Fabricate(:hours_spent, hour: 10,        task: @task, artisan: @artisan )
    @hours << Fabricate(:hours_spent, overtime_50: 50, task: @task, artisan: @artisan )
  end

  it 'has no syntax errors' do
    Timesheet.new(@project, @artisan, @hours).create_spreadsheet.class.should eq String
  end

  #it %q{returns a comma separated 
  #string with the sum of the hours each artisan has worked} do
  #  ExcelProjectTools.hours_for_artisans(@project).should eq ['20','19']
  #end

  #it %q{returns a comma separated string of names} do
  #  ExcelProjectTools.artisan_names(@project).should eq ['John',' Ali']
  #end


end
