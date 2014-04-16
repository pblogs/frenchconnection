require 'spec_helper'

describe Task do
  before :each do
    @artisan = Fabricate(:artisan)
    @task    = Fabricate(:task)
    @task2   = Fabricate(:task)
    @artisan.tasks = [@task, @task2]
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
    expect(@task.artisans).to include @artisan
  end

  it "an artisan can have many tasks" do
    expect(@artisan.tasks).to include(@task, @task2)
  end

end
