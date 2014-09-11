require 'spec_helper'

describe Task do
  before :each do
    @department = Fabricate(:department)
    @worker  = Fabricate(:user, first_name: 'John')
    @worker2 = Fabricate(:user, first_name: 'Barry')
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


  it "has one or more workers" do
    expect(@task.users).to include(@worker, @worker)
  end

  it "knows their names" do
    @task.name_of_users.should eq 'John, Barry'
  end

  describe "Notifications" do
    it "notifies by SMS when a worker is delegated at task" do
    end
  end

end
