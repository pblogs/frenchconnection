require 'spec_helper'

describe Project do
  before :each do
    @project  = Fabricate(:project)
    @artisan  = Fabricate(:artisan, name: 'John')
    @artisan2 = Fabricate(:artisan, name: 'Barry')
    @artisan3 = Fabricate(:artisan, name: 'Mustafa')
  end
  it "is valid from the Fabric" do
    expect(@project).to be_valid
  end


  it "knows which artisans that are involved" do
    @task = Fabricate(:task, project: @project)
    @task.artisans << @artisan
    @task.artisans << @artisan2
    @task.artisans << @artisan3
    @artisan.tasks.should include @task
    @project.artisans.should include(@artisan, @artisan2, @artisan3)
  end

  it "knows their names" do
    @project.name_of_artisans.should eq 'John, Barry, Mustafa'
  end

end
