require 'spec_helper'

describe Task do
  before :each do
    @artisan  = Fabricate(:artisan, name: 'John')
    @artisan2 = Fabricate(:artisan, name: 'Barry')
    @task    = Fabricate(:task)
    @task2   = Fabricate(:task)
    @task.artisan_ids = [@artisan.id, @artisan2.id]
    @task.save
    @task.reload
    @artisan.reload
  end
  
  it "is valid from the Fabric" do
    expect(@task).to be_valid
  end

  it "belongs to a project" do
    expect(@task.project.class).to eq Project
  end

  it "has a task type" do
    expect(@task.task_type.class).to eq TaskType
  end

  it "has one or more artisans" do
    expect(@task.artisans).to include(@artisan, @artisan2)
  end

  it "knows their names" do
    @task.name_of_artisans.should eq 'John, Barry'
  end

end
