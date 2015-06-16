# == Schema Information
#
# Table name: user_tasks
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  task_id    :integer          not null
#  status     :string           not null
#  created_at :datetime
#  updated_at :datetime
#

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

  describe 'when sms_employee is set in project' do
    let!(:project) { Fabricate(:project, sms_employee_when_new_task_created:
                              true) }
    let!(:task) { Fabricate(:task, project: project) }
    let!(:user) { Fabricate(:user) }
    it 'notifies each new worker by sms when created' do
      Sms.should_receive(:send_msg).with(to: "47#{user.mobile}",
             msg: I18n.t('sms.new_task'))
      task.users << user
      task.save!
    end
  end

  describe 'when sms_employee is not set in project' do
    let!(:project) { Fabricate(:project, sms_employee_when_new_task_created:
        false) }
    let!(:task) { Fabricate(:task, project: project) }
    let!(:user) { Fabricate(:user) }
    it 'does not notify new worker when created' do
      Sms.should_not_receive(:send_msg)

      task.users << user
      task.save!
    end
  end

end
