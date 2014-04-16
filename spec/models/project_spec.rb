require 'spec_helper'

describe Project do
  before :each do
    @project = Fabricate(:project)
    @artisan = Fabricate(:artisan)
  end
  it "is valid from the Fabric" do
    expect(@project).to be_valid
  end


  it "knows which artisans that are involved" do
    @task = Fabricate(:task, project: @project)
    @task.artisans << @artisan
    @artisan.tasks.should include @task
    @project.artisans.should include @artisan
  end

end
