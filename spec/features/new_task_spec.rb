require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'



describe "the signin process", :type => :feature do
  before :each do
    Fabricate(:artisan, name: 'Josh')
    Fabricate(:paint, title: 'Acryl')
    Fabricate(:paint, title: 'Beis')
    Fabricate(:task_type, title: 'Muring')
    Fabricate(:task_type, title: 'Maling')
  end

  it "signs me in" do
    visit frontpage_manager_path
    click_link 'Nytt oppdrag'
    click_link 'Opprett kunde'

    fill_in 'Navn', with: 'Oslo Sporveier AS'
    fill_in 'Addresse', with: 'Majorstuveien 12'
    fill_in 'Organisasjonsnummer', with: '000000000'
    fill_in 'Kontaktperson',  with: 'Ole Olsen'
    fill_in 'Telefonenummer', with: '22222222'
    click_button 'Lagre'


    click_link 'Registrer en nytt oppdrag på denne kunden'
    current_path.should == new_customer_task_path(Customer.last)
    #save_and_open_page
    

    # Oppdragstype
    select 'Maling', from: 'task_task_type_id'
    select 'Acryl',  from: 'task_paint_id'
    select 'Josh',   from: 'task_artisan_id'
    fill_in 'Oppstartsdato', with: '01.05.2014'
    click_button 'Lagre oppdrag i Visma'
    #expect(page).to have_content 'Success'
  end
end

#feature 'Return to new ad page after sign in', %q{
#  As an admin
#} do
#
#  background do
#    Fabricate(:artisan)
#  end
#
#  scenario 'Create a new assignemnt' do
#
#    visit frontpage_manager_path
#    within '#main' do
#      click "Opprett kunde"
#    end
#    fill_in 'Navn', with: 'Oslo Sporveier AS'
#    fill_in 'Addresse', with: 'Majorstuveien 12'
#    fill_in 'Organisasjonsnummer', with: '000000000'
#    fill_in 'Kontaktperson',  with: 'Ole Olsen'
#    fill_in 'Telefonenummer', with: '22222222'
#    within '#main' do
#      click('Lagre')
#    end
#
#    Customer.last.name.should eq 'Oslo Sporveier AS'
#
#  end
#  
#end

    #click_create_ad_icon
    #sidebar_should_be_open
    #current_path.should == ad_path(@ad.slug)
    #click_link I18n.t('auth.sign_in.link')

    #within '#page_content' do
    #  with_login_form do
    #    fill_in 'user_email',         with: @current_user.email
    #    fill_in 'password_plaintext', with: @current_user.password
    #  end
    #end
    #current_path.should == new_ad_path



=begin

describe "An admin creates a new task" do
  before :each do
    Fabricate(:artisan)
  end

  it "can create a new task" do 
    visit frontpage_manager_path
    click "Opprett kunde"
    fill_in 'Navn', with: 'Oslo Sporveier AS'
    fill_in 'Addresse', with: 'Majorstuveien 12'
    fill_in 'Organisasjonsnummer', with: '000000000'
    fill_in 'Kontaktperson',  with: 'Ole Olsen'
    fill_in 'Telefonenummer', with: '22222222'
    within '#main' do
      click('Lagre')
    end
    Customer.last.name.should eq 'Oslo Sporveier AS'
  end
  
end

=end
=begin
  describe "the signin process", :type => :feature do
    before :each do
      User.make(:email => 'user@example.com', :password => 'caplin')
    end
  
    it "signs me in" do
      visit '/sessions/new'
      within("#session") do
        fill_in 'Login', :with => 'user@example.com'
        fill_in 'Password', :with => 'password'
      end
      click_link 'Sign in'
      expect(page).to have_content 'Success'
    end
  end

=end
