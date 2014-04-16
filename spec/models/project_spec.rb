require 'spec_helper'

describe Project do
  before :each do
    @project  = Fabricate(:project)
    @artisan  = Fabricate(:artisan, name: 'John')
    @artisan2 = Fabricate(:artisan, name: 'Barry')
    @artisan3 = Fabricate(:artisan, name: 'Mustafa')
    @task = Fabricate(:task, project: @project)
    @task.artisans << @artisan
    @task.artisans << @artisan2
    @task.artisans << @artisan3
  end
  it "is valid from the Fabric" do
    expect(@project).to be_valid
  end


  it "knows which artisans that are involved" do

    @artisan.tasks.should include @task
    @project.artisans.should include(@artisan, @artisan2, @artisan3)
    @project.name_of_artisans.should eq 'John, Barry, Mustafa'
  end

  it "knows their names" do
    @project.name_of_artisans.should eq 'John, Barry, Mustafa'
  end

  it "knows how many hour each of them as worked" do
    @hours_spent = Fabricate(:hours_spent, hour: 10, task: @task, artisan: @artisan)
    @not_our_hours_spent = Fabricate(:hours_spent, hour: 10, task: @task, artisan: @artisan2)
    @project.hours_total_for(@artisan).should eq 10
  end

end
