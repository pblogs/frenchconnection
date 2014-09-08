require 'spec_helper'

describe HoursSpent do
  before(:all) do
    @department = Fabricate(:department)
    @worker     = Fabricate(:user)
    @task       = Fabricate(:task)
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

  it 'can have one change' do
    @change = Change.create_from_hours_spent(hours_spent: @hours_spent)
    @change.save
    @hours_spent.reload
    @hours_spent.change.should eq @change
  end

  #it 'sum()' do
  #  @change = Change.create_from_hours_spent(hours_spent: @hours_spent)
  #  @change.update_attribute(:overtime_50, 5)
  #  @hours_spent.sum(overtime: :overtime_50, changed: true) #.should eq 5
  #end

  #it 'sum(overtime: :overtime_50)' do
  #  @hours_spent.sum(overtime: :overtime_50).should eq 30
  #end

  it 'changed_value()' do
    pending 'This fails randomly. :-('

    @change = Change.create_from_hours_spent(hours_spent: @hours_spent)
    @change.update_attribute(:overtime_50, 5)
    @change.update_attribute(:overtime_100, 100)
    @hours_spent.changed_value(:overtime_50).should eq 5
    @hours_spent.changed_value(:overtime_100).should eq 100 
  end


end
