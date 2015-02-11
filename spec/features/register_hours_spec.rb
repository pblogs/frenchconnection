require 'spec_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

feature "Registered hours on a Task" do
  before :each do
    @user       = Fabricate(:user)
    @sporveiene = Fabricate(:customer, name: 'Oslo Sporveier AS')
    @project    = Fabricate(:project, customer: @sporveiene)
    @task       = Fabricate(:task, project: @project)
    @user.tasks << @task
    @hour       = Fabricate(:hours_spent, task: @task, hour: 10, user: @user)
    @project_leader     = Fabricate(:user, roles: [:project_leader])
  end

  context 'As an admin' do
    scenario "edit existing hours" do
      # Check total hours for project
      expect(@project.hours_spent_total(overtime: :hour)).to eq 10

      sign_in(@project_leader)
      visit user_hours_path(@user, @project)
      click_link 'edit_hour'
      fill_in HoursSpent.human_attribute_name("change_reason"),
        with: 'feil timer ført'
      fill_in HoursSpent.human_attribute_name("hour"), with: '111'
      fill_in HoursSpent.human_attribute_name("overtime_50"), with: '555'
      click_link_or_button I18n.t('save')
      expect(@project.hours_spent_total(overtime: :hour)).to eq 111
    end
  end
end

