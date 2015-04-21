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
#  supplies_from_warehouse :string
#  of_kind                 :string           default("personal")
#  billable_id             :integer
#  personal_id             :integer
#  approved                :boolean          default(FALSE)
#  change_reason           :text
#  old_values              :text
#  edited_by_admin         :boolean          default(FALSE)
#

require 'spec_helper'

describe HoursSpent do
  it "is valid from the Fabric" do
    @hours_spent  = Fabricate(:hours_spent)
    expect(@hours_spent).to be_valid
  end

  describe 'generic' do
    before(:all) do
      @department = Fabricate(:department)
      @user       = Fabricate(:user)
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
      @task.hours_total(of_kind: :personal).should eq 110
      @task.hours_total(of_kind: :billable).should eq 110
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
    before :all do
      @task = Fabricate(:task)
      @user = Fabricate(:user)
      Fabricate(:hours_spent, user: @user, task: @task, description: 'from user')
    end

    it 'generates one personal and one billable' do
      @user.hours_spents.billable.first.description.should eq 'from user'
      @user.hours_spents.personal.first.description.should eq 'from user'
    end

    it 'BILLABLE can save! without creating more HoursSpent' do
      @user.hours_spents.size.should eq 2
      @user.hours_spents.billable.first.save!
      @user.hours_spents.size.should eq 2
    end

    it 'PERSONAL can save! without creating more HoursSpent' do
      @user.hours_spents.size.should eq 2
      @user.hours_spents.personal.first.save!
      @user.hours_spents.size.should eq 2
    end



    it 'is invalid if change_reason is missing on update' do
      pending
      hour = Fabricate.build(:hours_spent, of_kind: :billable, change_reason: nil)
      hour.valid?
      hour.change_reason = nil
      expect(hour.errors.messages[:change_reason]).to eq ['kan ikke være blank']
    end

  end


end
