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
#  changed_hour_id         :integer
#  change_reason           :string(255)
#  changed_by_user_id      :integer
#

require 'spec_helper'

describe HoursSpent do
  describe 'generic' do
    before(:all) do
      @department = Fabricate(:department)
      @user     = Fabricate(:user)
      @task       = Fabricate(:task)
      @task.user_ids = [@user.id]
      @task.save
      @hours_spent = Fabricate(:hours_spent, user: @user, task: @task,
                                hour: 10,
                                piecework_hours: 10,
                                overtime_50: 30,
                                overtime_100: 50)
      @hours_spent.should be_valid
      @hours_spent2 = Fabricate(:hours_spent, user: @user, task: @task,
                                hour: 10)
      @hours_spent2.should be_valid
    end


    it "knows how many hour a user har registred on a task" do
      @task.hours_total.should eq 110
    end

    it "sums all kinds of hours for one registration" do
      @hours_spent.sum.should eq 100
    end


    it 'week_numbers_for_dates(dates)' do
      dates = [Date.parse('01-01-2014'), Date.parse('08-01-2014'), 
               Date.parse('15-01-2014'), Date.parse('29-01-2014')]
      HoursSpent.week_numbers_for_dates(dates).should eq '1, 2, 3, 5'
    end

    it 'week_numbers(hours_spents)' do
      hours_spents = [Fabricate(:hours_spent, date: Date.parse('01-01-2014')),
                      Fabricate(:hours_spent, date: Date.parse('08-01-2014')),
                      Fabricate(:hours_spent, date: Date.parse('08-01-2014')),
                      Fabricate(:hours_spent, date: Date.parse('15-01-2014')),
      ]
      HoursSpent.week_numbers(hours_spents).should eq '1, 2, 3'
    end
  end

  describe 'billable and personal hours' do
    before do
      @task = Fabricate(:task)
      @user = Fabricate(:user)
      HoursSpent.create_all(task: @task, user: @user, hour: 10,
         date: '01.01.2015', project: Fabricate(:project),
         description: 'bill and pers')
    end

    it 'creates both records on create_all' do
      @user.hours_spents.billable.first.description.should eq 'bill and pers'
      @user.hours_spents.personal.first.description.should eq 'bill and pers'
    end

    it 'find_billable(hour_id)' do
      billable = @user.hours_spents.billable.first
      personal = @user.hours_spents.personal.first
      HoursSpent.find_billable(personal.id).first.should eq billable
    end

    it 'find_personal(hour_id)' do
      billable = @user.hours_spents.billable.first
      personal = @user.hours_spents.personal.first
      HoursSpent.find_personal(billable.id).first.should eq personal
    end
  end


end
