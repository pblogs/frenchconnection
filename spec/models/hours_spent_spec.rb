# == Schema Information
#
# Table name: hours_spents
#
#  id                      :integer          not null, primary key
#  customer_id             :integer
#  task_id                 :integer
#  hour                    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  date                    :date
#  description             :text
#  user_id                 :integer
#  piecework_hours         :integer
#  overtime_50             :integer
#  overtime_100            :integer
#  project_id              :integer
#  runs_in_company_car     :integer
#  km_driven_own_car       :float
#  toll_expenses_own_car   :float
#  supplies_from_warehouse :string(255)
#

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



  it 'changed_value(:type_of_hour)' do
    # OBS: This has failed randomly earlier. 
    @change = Change.create_from_hours_spent(hours_spent: @hours_spent)
    @change.update_attribute(:overtime_50, 5)
    @change.update_attribute(:overtime_100, 100)
    @change.reload
    @hours_spent.reload
    @hours_spent.changed_value(:overtime_50).should eq 5
    @hours_spent.changed_value(:overtime_100).should eq 100
  end

  it 'week_numbers_for_dates(dates)' do
    dates = [Date.parse('01-01-2014'), Date.parse('08-01-2014'), 
             Date.parse('15-01-2014'), Date.parse('29-01-2014')]
    HoursSpent.week_numbers_for_dates(dates).should eq '1, 2, 3, 5'
  end

  it 'week_numbers(hours_spents)', focus: true do
    hours_spents = [Fabricate(:hours_spent, date: Date.parse('01-01-2014')),
                    Fabricate(:hours_spent, date: Date.parse('08-01-2014')),
                    Fabricate(:hours_spent, date: Date.parse('08-01-2014')),
                    Fabricate(:hours_spent, date: Date.parse('15-01-2014')),
    ]
    HoursSpent.week_numbers(hours_spents).should eq '1, 2, 3'
  end

  it


end
