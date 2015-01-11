require 'spec_helper'


describe "Create a new project", :type => :feature do
  before :all do
    @project_leader = Fabricate(:user, roles: [:project_leader])
  end

  it "for a new customer" do
    sign_in(@project_leader)
    visit root_path
    click_link I18n.t('top_nav.projects')
    click_link I18n.t('projects.create_new')
    click_link I18n.t('customers.new')

    # Create the new customer
    fill_in 'Navn', with: 'Oslo Sporveier AS'
    fill_in 'Addresse', with: 'Majorstuveien 12'
    fill_in 'Organisasjonsnummer', with: '000000000'
    fill_in 'Kontaktperson',  with: 'Ole Olsen'
    fill_in 'Telefonnummer', with: '22222222'
    click_button 'Lagre'

    # Then create the project
    click_link I18n.t('projects.create_new')
    fill_in Project.human_attribute_name("name"), with: 'Project name'
    fill_in Project.human_attribute_name("start_date"), with: '01.01.2014'
    fill_in Project.human_attribute_name("due_date"),   with: '01.10.2014'
    fill_in Project.human_attribute_name("description"), with: 'bra prosjekt'
    fill_in Project.human_attribute_name("project_number"), with: 'pl 22'
    fill_in Project.human_attribute_name("short_description"), with: 'short desc.'
    click_button 'Lagre'
  end

  it "search for an existing company" do
    @customer = Fabricate(:customer, name: 'Martins Mekkesenter')
    sign_in(@project_leader)
    expect{
      click_link I18n.t('top_nav.projects')
      click_link I18n.t('projects.create_new')

      fill_in 'query', with: 'Martins Mekkesenter'
      click_link_or_button I18n.t('search')
      within('#customer_search_result') do
        click_link "Martins Mekkesenter"
      end
      click_link I18n.t('projects.create_new')

      fill_in Project.human_attribute_name("start_date"), with: '01.01.2014'
      fill_in Project.human_attribute_name("due_date"),   with: '01.10.2014'
      fill_in Project.human_attribute_name("name"), with: 'Project name'
      fill_in Project.human_attribute_name("description"), with: 'bra prosjekt'
      fill_in Project.human_attribute_name("project_number"), with: 'pl 22'
      fill_in Project.human_attribute_name("short_description"), with: 'short desc.'

      click_button 'Lagre'
    }.to change(Project, :count).by(1)
  end

  describe "with single task" do
    before do
      @customer = Fabricate(:customer, name: 'Oslo Sporveier AS')
      sign_in(@project_leader)

      visit new_customer_project_path(@customer)
      fill_in Project.human_attribute_name("start_date"), with: '01.01.2014'
      fill_in Project.human_attribute_name("name"), with: 'Project name'
      fill_in Project.human_attribute_name("due_date"),   with: '01.10.2014'
      fill_in Project.human_attribute_name("description"), with: 'bra prosjekt'
      fill_in Project.human_attribute_name("project_number"), with: 'pl 22'
      fill_in Project.human_attribute_name("short_description"), with: 'short desc.'

      find(:css, '.single-task input[type=checkbox]').set(true)

      click_button 'Lagre'
    end

    it "redirects to created task" do
      current_path.should == edit_project_task_path(Project.last, Task.last)
    end

    it "has description and dates copied from project" do
      t = Task.last
      expect(t.start_date).to eq(t.project.start_date)
      expect(t.due_date).to eq(t.project.due_date)
      expect(t.description).to eq(t.project.short_description)
    end
  end

  def sign_in(user)
    visit root_path
    within '#main' do
      fill_in 'user_mobile', with: user.mobile
      fill_in 'user_password', with: 'topsecret'
      click_link_or_button 'Logg inn'
    end
    User.last.mobile.should eq user.mobile
  end

end
