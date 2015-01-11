require 'spec_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

feature "Task" do
  scenario "Create a new task", js: true do
    @project_leader = Fabricate(:user, roles: [:project_leader])
    project_start_date = '01.01.2014'
    @project        = Fabricate(:project, start_date: project_start_date)
    sign_in(@project_leader)

    visit customer_project_path(@project.customer, @project)
    expect {
      click_link I18n.t('register_new_task')
      fill_in Task.human_attribute_name("description"), with: 'bra prosjekt'
      fill_in Task.human_attribute_name("start_date"),  with: project_start_date
      click_link I18n.t('continue')
    }.to change(Task, :count).by(1)
  end


end

