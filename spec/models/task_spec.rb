# == Schema Information
#
# Table name: tasks
#
#  id                     :integer          not null, primary key
#  customer_id            :integer
#  task_type_id           :integer
#  start_date             :date
#  customer_buys_supplies :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  paint_id               :integer
#  accepted               :boolean
#  description            :string(255)
#  finished               :boolean          default(FALSE)
#  project_id             :integer
#  due_date               :date
#

require 'spec_helper'

describe Task do
  before :each do
    @department = Fabricate(:department)
    @worker = Fabricate(:user, first_name: 'John')
    @worker2 = Fabricate(:user, first_name: 'Barry')
    @task = Fabricate(:task)
    @task2 = Fabricate(:task)
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

  describe "Notifications" do
    it "notifies by SMS when a worker is delegated at task" do
    end
  end

  describe "validations" do

    before do
      @project = Fabricate :project, start_date: 1.month.ago, due_date: 1.month.since
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
