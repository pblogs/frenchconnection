require 'spec_helper'

describe User do
  before :each do
    @user  = Fabricate(:user)
  end

  it "is valid from the Fabric" do
    expect(@user).to be_valid
  end

  it "an user can have many tasks" do
    @task = Fabricate(:task)
    @task2 = Fabricate(:task)
    @user.tasks << @task
    @user.tasks << @task2
    expect(@user.tasks).to include(@task, @task2)
  end

end
