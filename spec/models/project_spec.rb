require 'spec_helper'

describe Project do
  before :each do
    @project  = Fabricate(:project)
    @user  = Fabricate(:user, first_name: 'John')
    @user2 = Fabricate(:user, first_name: 'Barry')
    @user3 = Fabricate(:user, first_name: 'Mustafa')
    @task = Fabricate(:task, project: @project)
    @task.users << @user
    @task.users << @user2
    @task.users << @user3
  end
  it "is valid from the Fabric" do
    expect(@project).to be_valid
  end


  it "knows which users that are involved" do

    @user.tasks.should include @task
    @project.users.should include(@user, @user2, @user3)
    @project.name_of_users.should eq 'John, Barry, Mustafa'
  end

  it "knows their names" do
    @project.name_of_users.should eq 'John, Barry, Mustafa'
  end

  it "knows how many hour each of them as worked" do
    Fabricate(:hours_spent, hour: 10, task: @task, user: @user)
    Fabricate(:hours_spent, piecework_hours: 10, task: @task, user: @user)
    # Test creating hours on an other user
    Fabricate(:hours_spent, hour: 10, task: @task, user: @user2)
    @project.hours_total_for(@user).should eq 20
  end

  it "is possible to list all hours spent for a particular user" do
    @hours_spent = Fabricate(:hours_spent, hour: 10, task: @task, user: @user)
    @project.hours_spents.where(user: @user).first.should eq @hours_spent
  end

  it "knows how many hour totally for the project" do
    Fabricate(:hours_spent, task: @task, hour: 10, user: @user)
    Fabricate(:hours_spent, task: @task, hour: 10, user: @user2)
    Fabricate(:hours_spent, task: @task, hour: 10, user: @user3)
    Fabricate(:hours_spent, task: @task, overtime_50:  10, user: @user2)
    Fabricate(:hours_spent, task: @task, overtime_100: 10, user: @user3)
    @project.reload
    @project.hours_spent_total.should eq 50
  end

end
