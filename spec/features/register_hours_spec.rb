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
    @user.tasks << @task
    @hour       = Fabricate(:hours_spent, description: 'painted wall', 
                            approved: false, task: @task,
                            hour: 10, user: @user)
    @project_leader = Fabricate(:user, roles: [:project_leader])
  end

  context 'As an admin' do
    #pending 'WIP'
    scenario "approve billable hours" do

      sign_in(@project_leader)
      visit project_hours_path(@project)
      click_link_or_button 'Billable'
      within(:css, 'h1.of_kind') do
        expect(page).to have_content 'billable'
      end
      #save_and_open_page
      #within(:css, 'table#hours_registered') do
      #  expect(page).to have_content 'painted wall'
      #end


      # Admin edits user's hour
      expect {
        click_link 'edit_hour'
        fill_in HoursSpent.human_attribute_name("description"),
          with: 'updated by admin'
        fill_in HoursSpent.human_attribute_name("change_reason"),
          with: 'slept during work'
        fill_in HoursSpent.human_attribute_name("hour"), with: '111'
        fill_in HoursSpent.human_attribute_name("overtime_50"), with: '555'
        click_link_or_button I18n.t('save')
        visit user_hours_path(@user, @project)
      }.to change{ @project.hours_spent_total(overtime: :hour, of_kind: :billable) }.from(0).to(111)
      within(:css, 'table#hours_registered') do
        expect(page).to     have_content 'updated by admin'
        expect(page).to     have_content 'slept during work'
        expect(page).to_not have_content 'by user'
      end

      # Admin updates his edited hour
      expect {
        click_link 'edit_hour'
        fill_in HoursSpent.human_attribute_name("description"),
          with: 'updating edited hour'
        fill_in HoursSpent.human_attribute_name("change_reason"),
          with: 'was hungover'
        fill_in HoursSpent.human_attribute_name("hour"), with: '22'
        fill_in HoursSpent.human_attribute_name("overtime_50"), with: '500'
        click_link_or_button I18n.t('save')
        visit user_hours_path(@user, @project)
      }.to change{ @project.hours_spent_total(overtime: :hour) }.from(111).to(22)
      within(:css, 'table#hours_registered') do
        expect(page).to     have_content 'updating edited hour'
        expect(page).to     have_content 'was hungover'
        expect(page).to_not have_content 'updated by admin'
        expect(page).to_not have_content 'slept during work'
        expect(page).to_not have_content 'by user'
      end
      
    end

    #scenario 'approve hours in scope: /projects/1/hours'do
    #  sign_in(@project_leader)
    #  visit hours_path(@project)
    #  click_link_or_button I18n.t('hours_spent.show_all')
    #  #save_and_open_page
    #  within(:css, 'table#hours_registered') do
    #    expect(page).to have_content 'Nei'
    #  end
    #  click_link_or_button I18n.t('hours_spent.approve_all_hours')
    #  click_link_or_button I18n.t('hours_spent.show_all')
    #  within(:css, 'table#hours_registered') do
    #    expect(page).to have_content 'Ja'
    #  end
    #end

  end

end

