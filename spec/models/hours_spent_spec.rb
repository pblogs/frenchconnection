require 'spec_helper'

describe HoursSpent do
  before(:all) do
    @worker  = Fabricate(:user, roles: 'worker', first_name: 'John')
    @task    = Fabricate(:task)
    @task.user_ids = [@worker.id]
    @task.save
    Fabricate(:hours_spent, user: @worker, task: @task, hour: 10)
    Fabricate(:hours_spent, user: @worker, task: @task, piecework_hours: 10)
    Fabricate(:hours_spent, user: @worker, task: @task, overtime_50: 30)
    Fabricate(:hours_spent, user: @worker, task: @task, overtime_100: 50)
  end

  it "knows how many hour a worker har registred" do
    @task.hours_total.should eq 100
  end
end
