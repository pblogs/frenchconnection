require 'spec_helper'

describe Task do
  before :each do
    @worker  = Fabricate(:user, roles: 'worker', first_name: 'John')
    @worker2 = Fabricate(:user, roles: 'worker', first_name: 'Barry')
    @task    = Fabricate(:task)
    @task2   = Fabricate(:task)
    @task.user_ids = [@worker.id, @worker2.id]
    @task.save
    @task.reload
    @worker.reload
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

  it "has one or more workers" do
    expect(@task.users).to include(@worker, @worker)
  end

  it "knows their names" do
    @task.name_of_artisans.should eq 'John, Barry'
  end

end
