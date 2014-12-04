# == Schema Information
#
# Table name: tasks
#
#  id                     :integer          not null, primary key
#  customer_id            :integer
#  start_date             :date
#  customer_buys_supplies :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  accepted               :boolean
#  description            :string(255)
#  finished               :boolean          default(FALSE)
#  project_id             :integer
#  due_date               :date
#  ended_at               :datetime
#

require 'spec_helper'

describe Task do
  before(:each) do
    @department = Fabricate(:department)
    @worker     = Fabricate(:user, first_name: 'John')
    @worker2    = Fabricate(:user, first_name: 'Barry')
    @task       = Fabricate(:task)
    @task.users = [@worker, @worker2]
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


  describe "Ending a task" do
    before(:all) do
      @admin      = Fabricate(:user, first_name: 'Mr Admin')
      @project    = Fabricate(:project)
      @task       = Fabricate(:task, project: @project)
      @task.users = [Fabricate(:user), Fabricate(:user)]
      @task.save
    end

    it 'in_progress?' do
      @task.user_tasks.each { |t| t.update_attribute(:status, :complete) }
      @task.user_tasks.last.update_attribute(:status, :confirmed)
      @task.in_progress?.should eq true
    end

    it 'in_progress? if all UserTasks are completed?' do
      @task.user_tasks.each { |t| t.update_attribute(:status, :complete) }
      @task.in_progress?.should eq false
    end

    it 'complete?' do
      @task.user_tasks.each { |t| t.update_attribute(:status, :complete) }
      @task.complete?.should eq true
    end

    it 'complete? if one UserTask is not?' do
      @task.user_tasks.each { |t| t.update_attribute(:status, :complete) }
      @task.user_tasks.last.update_attribute(:status, :confirmed)
      @task.complete?.should eq false
    end

    it 'closes all UserTasks' do
      UserTask.where(task_id: @task.id).all.each { |ut| ut.status.should eq :pending }
      @task.end_task_hard
      @task.save!
      @task.reload
      UserTask.where(task_id: @task.id).all.each { |ut| ut.status.should eq :complete }
    end

  end

  describe "Notifications", focus: true do
    before do
      @project = Fabricate(:project, sms_employee_when_new_task_created: true)
      @task    = Fabricate(:task, project: @project)
    end
    it "notifies by SMS when a worker is delegated at task" do
      @user = Fabricate(:user, mobile: 93441707)
      @task.users << @user
      @task.save
      Sms.any_instance.should_receive(:send_msg)
      Sms.send_msg(to: 4793441707, msg: 'hi') # This should at least trigger the line below?
    end
  end

  describe "validations" do
    before do
      @project = Fabricate :project, 
        start_date: 1.month.ago, due_date: 1.month.since
    end

    %i(start_date due_date).each do |s|

      it "fails validation with #{s} before projects start_date" do
        task = @project.tasks.build s => 2.months.ago
        task.valid?
        expect(task.errors[s].size).to eq(1)
      end

      it "passes validation with #{s} within projects start_date/due_date" do
        task = @project.tasks.build s => 1.day.ago
        task.valid?
        expect(task.errors[s].size).to eq(0)
      end
    end
  end

end
