# == Schema Information
#
# Table name: tasks
#
#  id               :integer          not null, primary key
#  customer_id      :integer
#  start_date       :date
#  created_at       :datetime
#  updated_at       :datetime
#  accepted         :boolean
#  description      :string
#  finished         :boolean          default(FALSE)
#  project_id       :integer
#  due_date         :date
#  ended_at         :datetime
#  work_category_id :integer
#  location_id      :integer
#  profession_id    :integer
#  skills_ids       :integer
#  draft            :boolean          default(TRUE)
#  address          :string
#  custom_id        :string
#  owner_id         :integer
#

require 'spec_helper'

describe Task do

  describe 'Basics' do
    before :each do
      @department = Fabricate(:department)
      @owner      = Fabricate.build(:user, first_name: 'John', last_name: 'Doe')
      @owner.save!
      @owner.department.save!
      @project    = Fabricate(:project, user: @owner)
      @worker     = Fabricate(:user, first_name: 'John')
      @worker2    = Fabricate(:user, first_name: 'Barry')
      @task       = Fabricate(:task, project: @project, address: nil, owner: @owner)
      @task.users = [@worker, @worker2]
      @task.save
      @task.reload
      @worker.reload
    end

    it "is valid from the Fabric"  do
      expect(@task).to be_valid
    end

    it 'has a custom ID. Owner initials pluss digits' do
      expect(@task.custom_id).to match(/#{@task.owner.initials}[\d]{5}/)
    end

    it 'has a an owner' do
      expect(@task.owner).to eq @owner
    end

    it "belongs to a project" do
      expect(@task.project.class).to eq Project
    end

    it 'inherits the projects address, if non other provided' do
      expect(@task.address).to eq @task.project.address
    end

    it "has one or more workers" do
      expect(@task.users).to include(@worker, @worker)
    end

    it "should create nested valid attachments" do
      @task.update({
        attachments_attributes: {
          '0' => {
            description: "description", 
            document: fixture_file_upload('3568357401_b1c9a7e181_o-1000-400x400.jpg')
          }
        }
      })
      expect(@task.attachments).not_to be_empty
    end


    it "knows their names" do
      @task.name_of_users.should eq 'John, Barry'
    end
  end


  describe "Ending a task" do
    before(:each) do
      Task.destroy_all
      UserTask.destroy_all
      @task       = Fabricate(:task)
      @task.users = [Fabricate(:user), Fabricate(:user)]
      @task.save
    end

    it 'in_progress?' do
      @task.update_attribute(:draft, false)
      @task.user_tasks.each { |t| t.update_attribute(:status, :complete) }
      @task.user_tasks.last.update_attribute(:status, :confirmed)
      @task.save!
      @task.reload
      @task.in_progress?.should eq true
    end

    it 'in_progress? if all UserTasks are completed?'  do
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
      UserTask.where(task_id: @task.id).all.each { |ut| ut.status.should eq :complete }
    end

  end


  describe 'Location' do
    before do
      @roof_top =  Fabricate(:location, name: 'Roof top')
      @task = Fabricate(:task, location: @roof_top)
    end
    it 'has a location' do
      @task.location.should eq @roof_top
    end
  end

  describe "Notifications" do
    before do
      @project = Fabricate(:project, sms_employee_when_new_task_created: true)
      @task    = Fabricate(:task, project: @project, draft: false)
      @user    = Fabricate(:user, mobile: 93441707)
    end

    it "notifies by SMS when a worker is delegated at task" do
      Sms.should_receive(:send_msg)
      @task.users << @user
      @task.save
    end

    it "does not send any SMS on a task that is draft" do
      Sms.should_not_receive(:send_msg)
      @task.update_attribute(:draft, true)
      @task.users << @user
      @task.save
    end

    it 'sends sms to all users when a task is no longer a draft' do
      # A tasks starts as draft. @task.draft is set as false when
      # save_and_order_resources! is excuted.
      @task.update_attribute(:draft, true)
      Sms.should_receive(:send_msg).with(to: "47#{@user.mobile}",
                                        msg: I18n.t('sms.new_task'))
      @task.users << @user
      @task.save_and_order_resources!
      expect(@task.draft).to eq false
    end

    it "notifies only new workers when task is updated" do
      Sms.should_receive(:send_msg).with(to: "47#{@user.mobile}",
                                        msg: I18n.t('sms.new_task'))
      @task.users << @user
      @user_second = Fabricate(:user)
      Sms.should_receive(:send_msg).with(to: "47#{@user_second.mobile}",
                                         msg: I18n.t('sms.new_task'))
      Sms.should_not_receive(:send_msg).with(to: "47#{@user.mobile}")
      @task.users << @user_second
    end
  end

  describe "Validations" do
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

  describe 'Resources' do
    before { User.destroy_all; Certificate.destroy_all }
    let!(:dep)              { Fabricate(:department) }
    let!(:project)          { Fabricate(:project, department: dep)  }
    let!(:task)             { Fabricate(:task, project: project)  }
    let!(:lift_certificate) { Fabricate(:certificate, title: 'Lift')  }
    let!(:blender)          { Fabricate(:inventory, name: 'Concrete blender') }
    let!(:lift)             { Fabricate(:inventory, name: 'Lift 2000') }
    let!(:lift_operator)    { Fabricate(:user, roles: [:worker],
                                first_name: 'Lift Oper', department: dep ) }
    let!(:user_with_no_certs) { Fabricate(:user, roles: [:worker],
                                  first_name: 'Unskilled', department: dep) }

    let!(:user_from_different_department) { Fabricate(:user, roles: [:worker]) }
    let!(:user_certificate) { Fabricate(:user_certificate, user: lift_operator, certificate: lift_certificate) }

    it 'knows which users that can do the job' do
      lift.certificates << lift_certificate
      lift.save!
      task.inventories << lift
      task.save!
      task.reload
      expect(lift.certificates.first).to eq lift_certificate
      expect(task.qualified_workers).to eq [lift_operator]
    end

    it 'lists all users for a tool that does not require a certificate' do
      task.inventories << blender
      task.save
      expect(task.qualified_workers).to eq [lift_operator, user_with_no_certs]
    end

    it 'lists all users if the task does not contain any tools' do
      expect(task.qualified_workers).to include(lift_operator, user_with_no_certs)
      expect(task.qualified_workers).to_not include(user_from_different_department)
    end

    it 'lists qualitications except those who are selected already' do
      task.users << lift_operator
      task.save
      task.reload
      expect(task.qualified_workers).to eq [user_with_no_certs]
    end
  end
end
