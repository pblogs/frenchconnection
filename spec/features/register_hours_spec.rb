require 'spec_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

feature "Registered hours on a Task" do
  before :all do
    @user       = Fabricate(:user)
    @sporveiene = Fabricate(:customer, name: 'Oslo Sporveier AS')
    @project    = Fabricate(:project, customer: @sporveiene)
    @task       = Fabricate(:task, project: @project)
    #HoursSpent.destroy_all
    @user.tasks << @task
    @hour       = Fabricate(:hours_spent, description: 'by user', 
                            approved: false, task: @task,
                            hour: 10, user: @user)
    @project_leader = Fabricate(:user, roles: [:project_leader])
  end

  context 'As an admin' do
    scenario "edit existing hours" do
    pending
      # not counting hours that is not approved
      expect(@project.hours_spent_total(overtime: :hour)).to eq 0

      sign_in(@project_leader)
      visit user_hours_path(@user, @project)
      within(:css, 'table#hours_registered') do
        expect(page).to have_content 'by user'
      end

      save_and_open_page
      click_link 'edit_hour'
      fill_in HoursSpent.human_attribute_name("description"), with: 'updated by admin'
      fill_in HoursSpent.human_attribute_name("change_reason"),
        with: 'feil timer ført'
      fill_in HoursSpent.human_attribute_name("hour"), with: '111'
      fill_in HoursSpent.human_attribute_name("overtime_50"), with: '555'
      click_link_or_button I18n.t('save')

      expect(@project.hours_spent_total(overtime: :hour)).to eq 111
      #binding.pry
      #raise "Last #{HoursSpent.last.inspect}"
      #save_and_open_page
      within(:css, 'table#hours_registered') do
        expect(page).to have_content 'updated by admin'
      end
    end
  end
end

