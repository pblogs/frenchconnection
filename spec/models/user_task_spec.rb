require 'spec_helper'

describe UserTask do
  before :each do
    @user_task  = Fabricate(:user_task)
  end

  it "is valid from the Fabric" do
    expect(@user_task).to be_valid
  end

  it "belongs to user" do
    expect(@user_task.user).to_not be_nil
  end

  it "belongs to task" do
    expect(@user_task.task).to_not be_nil
  end

  it "has default status" do
    expect(@user_task.status).to eq :pending
  end

  it "changes its status after completing" do
    @user_task.complete!
    expect(@user_task.reload.status).to eq :complete
  end

end
