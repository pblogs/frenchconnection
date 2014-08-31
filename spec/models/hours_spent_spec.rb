require 'spec_helper'

describe HoursSpent do
  before(:all) do
    @department = Fabricate(:department)
    @worker  = Fabricate(:user, roles: ['worker'], first_name: 'John', department: @department, emp_id: "12121")
    @task    = Fabricate(:task)
    @task.user_ids = [@worker.id]
    @task.save
    @hours_spent = Fabricate(:hours_spent, user: @worker, task: @task, 
                              hour: 10,
                              piecework_hours: 10,
                              overtime_50: 30,
                              overtime_100: 50)
    @hours_spent.should be_valid

    @hours_spent2 = Fabricate(:hours_spent, user: @worker, task: @task, 
                              hour: 10)
    @hours_spent2.should be_valid


  end

  it "knows how many hour a worker har registred on a task" do
    @task.hours_total.should eq 110
  end

  it "sums all kinds of hours for one registration" do
    @hours_spent.sum.should eq 100
  end

end
