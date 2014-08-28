require 'spec_helper'

describe Project do
  describe "generic" do
    before :each do
      @project_leader  = Fabricate(:user)
      @service         = Fabricate(:department, title: 'Service')
      @project         = Fabricate(:project, user: @project_leader, 
                                   department: @service)
      @user  = Fabricate(:user, first_name: 'John')
      @user2 = Fabricate(:user, first_name: 'Barry')
      @user3 = Fabricate(:user, first_name: 'Mustafa')
      @task  = Fabricate(:task, project: @project)
      @task.users << @user
      @task.users << @user2
      @task.users << @user3
    end

    it "is valid from the Fabric" do
      expect(@project).to be_valid
    end

     it "Belongs to a project leader" do
       @project.user.should eq @project_leader
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

  describe "Project owner" do
    before do
      User.destroy_all
      Project.destroy_all
      Category.destroy_all
      @user         = Fabricate(:user, first_name: 'John')
      @service      = Fabricate(:department, title: 'Service')
      @maintainance = Fabricate(:department, title: 'Maintainance')
      @customer1    = Fabricate(:customer)
      @customer2    = Fabricate(:customer)
      @service_project1 = Fabricate(:project, user: @user, 
                                    customer: @customer1, 
                                    department: @service)
      @maintainance_project1 = Fabricate(:project, user: @user, 
                                         customer: @customer2, 
                      department: @maintainance)
    end

    it "knows which projects that are mine" do
      pending "works when testing manually"
      @user.reload
      @user.owns_projects.to_a.should eq [@service_project1, 
                                          @service_project2, 
                                          @maintainance_project1]
    end

    it "lists the departments my projects belong to" do
      @user.reload
      @user.project_departments.to_a.should eq [@service, @maintainance]
    end

    it "lists the customers that has a project belonging to a department" do
      pending "works when testing manually"
      @service.customers.should include [@customer1]
    end
  end

end
