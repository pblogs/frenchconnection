require 'spec_helper'


describe "Create a new project", :type => :feature do
  before :all do
    Customer.destroy_all
    @project_leader = Fabricate(:user, roles: ['project_leader'])
  end

  it "for a new company", js: true do
    sign_in(@project_leader)
    visit user_path(@project_leader)
    current_path.should eq user_path(@project_leader)
    click_link 'Opprett nytt prosjekt'
    click_link 'Opprett kunde'

    fill_in 'Navn', with: 'Oslo Sporveier AS'
    fill_in 'Addresse', with: 'Majorstuveien 12'
    fill_in 'Organisasjonsnummer', with: '000000000'
    fill_in 'Kontaktperson',  with: 'Ole Olsen'
    fill_in 'Telefonnummer', with: '22222222'
    click_button 'Lagre'


    click_link 'Lag et nytt prosjekt'
    current_path.should == new_customer_project_path(Customer.last)
    fill_in 'Oppstartsdato', with: '01.05.2014'
    click_button 'Lagre'
  end

  it "for an existing company" do
    pending "WIP"
    Fabricate(:customer, name: 'Oslo Sporveier AS')
    sign_in(@project_leader)
    click_link 'Min side'
    click_link 'Opprett nytt prosjekt'

    select 'Oslo Sporveier AS', from: :customer
    click_link 'Registrer prosjekt'
    current_path.should == new_customer_project_path(Customer.last)

    fill_in 'Oppstartsdato', with: '01.01.2014'
    fill_in 'Dato for ferdigstillelse av oppdrag', with: '01.10.2014'
    fill_in 'Beskrivelse', with: 'bra prosjekt'
    click_button 'Lagre'
  end

  describe "with single task" do
    before do
      @customer = Fabricate(:customer, name: 'Oslo Sporveier AS')
      sign_in(@project_leader)

      visit new_customer_project_path(@customer)

      fill_in 'Prosjektnummer', with: 'abc'
      fill_in 'Oppstartsdato', with: '01.01.2014'
      fill_in 'Dato for ferdigstillelse av oppdrag', with: '01.10.2014'
      fill_in 'Beskrivelse', with: 'bra prosjekt'
      fill_in 'Kort beskrivelse', with: 'bra prosjekt'

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
    #click_link I18n.t('auth.sign_in.link')
    within '#main' do
      fill_in 'user_mobile', with: user.mobile
      fill_in 'user_password', with: 'topsecret'
      click_link_or_button 'Logg inn'
    end
    User.last.mobile.should eq user.mobile
  end

end
