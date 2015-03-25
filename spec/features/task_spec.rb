require 'spec_helper'

feature "Task",  type: :feature do
  before do
    @project_leader     = Fabricate(:user, roles: [:project_leader])
    @project_start_date = '01.01.2014'
    @project            = Fabricate(:project, start_date: @project_start_date)
    @skill              = Fabricate(:skill, title: 'welding')
    @location           = Fabricate(:location, name: 'roof-top')
    @lift_cert          = Fabricate(:certificate, title: 'lift certificate')
    @lift               = Fabricate(:inventory, name: 'lift',
                                     certificates: [@lift_cert])
    @lisa_lift_operator = Fabricate(:user)
    @user_certificate   = Fabricate(:user_certificate, user: @lisa_lift_operator,
                                    certificate: @lift_cert )
  end

  scenario "Create a new task", js: true  do
    sign_in(@project_leader)
    visit customer_project_path(@project.customer, @project)
    expect {
      click_link I18n.t('register_new_task')
      check  @skill.title
      choose @location.name
      fill_in Task.human_attribute_name("description"), with: 'welding on top'
      click_link_or_button I18n.t('save_and_continue')
    }.to change(Task, :count).by(1)

    # The tools page
    expect {
      fill_in 'search', with: 'lift'
      within(:css, '#searchTextResults') do
        page.should have_content @lift.name
        click_link_or_button I18n.t('select')
      end
      page.should have_content I18n.t('projects.tasks.tools.selected_tools')
    }.to change{ Task.last.inventories.first }.from(nil).to(@lift)
    click_link I18n.t('save_and_continue')

    # The workers page
    expect {
      within(:css, 'table#workers') do
        page.should have_content @lisa_lift_operator.first_name
        click_link_or_button I18n.t('select')
      end
      page.should have_content I18n.t('projects.tasks.workers.selected_workers')
    }.to change{ Task.last.users.first }.from(nil).to(@lisa_lift_operator)
    click_link I18n.t('task.review_and_submit')

    # The review page
    page.should have_content @location.name
    page.should have_content @lift.name
    page.should have_content @lisa_lift_operator.first_name
    expect {
      click_link I18n.t('task.order_resources_and_save_task')
    }.to change{ Task.last.draft }.from(true).to(false)

  end
end
