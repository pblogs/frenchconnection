# == Schema Information
#
# Table name: projects
#
#  id                                   :integer          not null, primary key
#  project_number                       :string(255)
#  name                                 :string(255)
#  created_at                           :datetime
#  updated_at                           :datetime
#  customer_id                          :integer
#  start_date                           :date
#  due_date                             :date
#  description                          :text
#  user_id                              :integer
#  execution_address                    :string(255)
#  customer_reference                   :text
#  comment                              :text
#  sms_employee_if_hours_not_registered :boolean          default(FALSE)
#  sms_employee_when_new_task_created   :boolean          default(FALSE)
#  department_id                        :integer
#  short_description                    :string(255)
#  complete                             :boolean          default(FALSE)
#

require 'spec_helper'

describe Project do
  describe "generic" do
    before :each do
      @department      = Fabricate(:department)
      @project_leader  = Fabricate(:user)
      @service         = Fabricate(:department, title: 'Service')
      @project         = Fabricate(:project, user: @project_leader,
                                   department: @service)
      @snekker = Fabricate(:profession, title: 'snekker')
      @murer   = Fabricate(:profession, title: 'murer')
      @john_snekker  = Fabricate(:user, first_name: 'John', last_name: 'W',
                                 profession: @snekker)
      @barry_snekker = Fabricate(:user, first_name: 'Barry',last_name: 'W',
                                 profession: @snekker)
      @mustafa_murer = Fabricate(:user, first_name: 'Mustafa',last_name: 'W',
                                 profession: @murer)

      @task  = Fabricate(:task, project: @project)
      @task.users << @john_snekker
      @task.users << @barry_snekker
      @task.users << @mustafa_murer
      @task.save
      @project.save

      @hours_for_snakker1 = Fabricate(:hours_spent, hour: 10,
                                      task: @task,
                                      user: @john_snekker)
      @hours_for_snakker2 = Fabricate(:hours_spent, piecework_hours: 10,
                                      task: @task,
                                      user: @john_snekker)
      # Overtime 100
      @overtime_100_for_john_s  = Fabricate(:hours_spent, overtime_100: 100,
                                            task: @task,
                                            user: @john_snekker)
    end

    it "is valid from the Fabric" do
      expect(@project).to be_valid
    end

     it "Belongs to a project leader" do
       @project.user.should eq @project_leader
     end

    it "knows which users that are involved" do
      @john_snekker.tasks.should include @task
      @project.users.should include(@john_snekker, @barry_snekker, @mustafa_murer)
    end

    it "knows their names" do
      @project.name_of_users.should eq 'John W, Barry W, Mustafa W'
    end

    describe 'hours_total_for(user)' do
      it "knows how many hours each of them as worked" do
        Fabricate(:hours_spent, hour: 10, task: @task, user: @john_snekker)
        Fabricate(:hours_spent, piecework_hours: 10, task: @task, user: @john_snekker)
        # Test creating hours on an other user
        Fabricate(:hours_spent, hour: 10, task: @task, user: @barry_snekker)
        @project.hours_total_for(@john_snekker, overtime: :hour).should eq 20
      end

      it 'hours_total_for(user, changed: true)' do

        @change1 = Change.create_from_hours_spent(hours_spent: @hours_for_snakker1,
                                                 reason: 'works slow' )
        @change2 = Change.create_from_hours_spent(hours_spent: @hours_for_snakker2,
                                                 reason: 'works slow' )
        @change1.hour            = 1
        @change2.piecework_hours = 1
        @change1.save
        @change2.save

        @project.hours_total_for(@john_snekker, changed: true, overtime: :hour).should eq 1
      end

      it 'INVERTED test hours_spent_for_profession(profession, overtime: overtime)' do
        @project.hours_spent_for_profession(@snekker, overtime: :hour)
          .should_not include(@overtime_100_for_john_s)
      end

      it 'hours_spent_for_profession(profession, overtime: overtime)' do
        @project.hours_spent_for_profession(@snekker, overtime: :hour)
          .should include(@hours_for_snakker1)
      end

      it "hours_spent_total" do
        HoursSpent.destroy_all
        Fabricate(:hours_spent, task: @task, hour: 10, user: @john_snekker)
        Fabricate(:hours_spent, task: @task, hour: 10, user: @barry_snekker)
        Fabricate(:hours_spent, task: @task, hour: 10, user: @mustafa_murer)
        Fabricate(:hours_spent, task: @task,
                  overtime_50: 10, user: @barry_snekker)
        Fabricate(:hours_spent, task: @task, overtime_100: 10,
                           user: @mustafa_murer)
        @project.reload
        @project.hours_spent_total(profession: @snekker, overtime: :hour).should eq 20
      end

      it "hours_spent_total(changed: true)" do
        HoursSpent.destroy_all
        @hour10 = Fabricate(:hours_spent, task: @task, hour: 10, user: @john_snekker)
        @change = Change.create_from_hours_spent(hours_spent: @hour10,
                                                 reason: 'works slow' )
        @change.update_attribute(:hour, 1)
        @change.reload
        @project.reload
        @project.hours_spent_total(profession: @snekker,
                                   changed: true, overtime: :hour).should eq 1
      end
    end


    describe "lists week numbers" do
      before do
        HoursSpent.destroy_all
        Fabricate(:hours_spent, date: '01.01.2014', task: @task, hour: 10,
                  user: @john_snekker)
        Fabricate(:hours_spent, date: '09.01.2014', task: @task, hour: 10,
                  user: @mustafa_murer)
        Fabricate(:hours_spent, date: '14.01.2014', task: @task, hour: 10,
                  user: @barry_snekker)
      end
      it 'week_numbers' do
        @project.week_numbers.should eq "1, 2, 3"
      end
      it 'week_numbers(profession: @profession)' do
        @project.week_numbers(profession: @snekker).should eq "1, 3"
      end
    end

    it "lists all types of professions involved" do
      @project.professions.should eq [@snekker, @murer]
    end
  end

  describe "Project owner" do
    before do
      User.destroy_all
      Project.destroy_all
      Department.destroy_all
      @john_snekker         = Fabricate(:user, first_name: 'John')
      @service      = Fabricate(:department, title: 'Service')
      @maintainance = Fabricate(:department, title: 'Maintainance')
      @customer1    = Fabricate(:customer)
      @customer2    = Fabricate(:customer)
      @service_project1 = Fabricate(:project, user: @john_snekker,
                                    customer: @customer1,
                                    department: @service)
      @maintainance_project1 = Fabricate(:project, user: @john_snekker,
                                         customer: @customer2,
                      department: @maintainance)
    end

    it "knows which projects that are mine" do
      pending "works when testing manually"
      @john_snekker.reload
      @john_snekker.owns_projects.to_a.should eq [@service_project1,
                                          @service_project2,
                                          @maintainance_project1]
    end

    it "lists the departments my projects belong to" do
      @john_snekker.reload
      @john_snekker.project_departments.to_a.should eq [@service, @maintainance]
    end

    it "lists the customers that has a project belonging to a department" do
      pending "works when testing manually"
      @service.customers.should include [@customer1]
    end
  end

  describe "Drafts" do
    before do
      @project = Fabricate(:project)
      @task1   = Fabricate(:task, project: @project, draft: true)
    end
    it 'task_drafts' do
      expect(@project.task_drafts.to_a).to eq [@task1]
    end
  end

  describe "In progress" do
    before do
      @project = Fabricate(:project)
      @task1   = Fabricate(:task, project: @project)
      @task2   = Fabricate(:task, project: @project)
      @user1   = Fabricate(:user)
      @user2   = Fabricate(:user)
      @task1.users = [@user1, @user2]
      @task1.save
    end

    it 'tasks_in_progress' do
      @project.tasks_in_progress.should eq [@task1]
    end

    it 'completed_tasks' do
      @task2.user_tasks.each { |t| t.update_attribute(:status, :complete) }
      @project.completed_tasks.should eq [@task2]
    end
    
  end

end
