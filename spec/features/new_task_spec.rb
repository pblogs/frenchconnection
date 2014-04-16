require 'spec_helper'



describe "Create a new task", :type => :feature do
  before :each do
    Fabricate(:artisan, name: 'Josh')
    Fabricate(:paint, title: 'Acryl')
    Fabricate(:paint, title: 'Beis')
    Fabricate(:task_type, title: 'Muring')
    Fabricate(:task_type, title: 'Maling')
    Fabricate(:customer, name: 'Oslo Sporveier AS')
  end

  it "for a new company" do
    visit frontpage_manager_path
    click_link 'Opprett nytt prosjekt'
    click_link 'Opprett kunde'

    fill_in 'Navn', with: 'Oslo Sporveier AS'
    fill_in 'Addresse', with: 'Majorstuveien 12'
    fill_in 'Organisasjonsnummer', with: '000000000'
    fill_in 'Kontaktperson',  with: 'Ole Olsen'
    fill_in 'Telefonenummer', with: '22222222'
    click_button 'Lagre'


    click_link 'Lag et nytt prosjekt'
    current_path.should == new_customer_project_path(Customer.last)
    #save_and_open_page
    

    # Oppdragstype
    #select 'Maling', from: 'task_task_type_id'
    #select 'Acryl',  from: 'task_paint_id'
    #select 'Josh',   from: 'task_artisan_id'
    fill_in 'Oppstartsdato', with: '01.05.2014'
    click_button 'Lagre oppdrag i Visma'
  end

  it "for an existing company", js: true do
    pending "WIP"
    visit frontpage_manager_path
    click_link 'Nytt oppdrag'

    Customer.first.name.should eq 'Oslo Sporveier AS'
    select 'Oslo Sporveier AS', from: :customer
    save_and_open_page
    click_link 'Registrer oppdrag'
    #current_path.should eq new_customer_task_path(@sporveiene)
    #page.should have_content 'Nytt oppdrag for Oslo Sporveier AS'
  end



end



#
#end
#
#
#
#    Fabricate(:task_type, title: 'Maling')
#    Fabricate(:customer,  name: 'Oslo Sporveier')
#  end
#
#  it "for an existing company" do
#    visit frontpage_manager_path
#    click_link 'Nytt oppdrag'
#    click_link 'Opprett kunde'
#
#    fill_in 'Navn', with: 'Oslo Sporveier AS'
#    fill_in 'Addresse', with: 'Majorstuveien 12'
#    fill_in 'Organisasjonsnummer', with: '000000000'
#    fill_in 'Kontaktperson',  with: 'Ole Olsen'
#    fill_in 'Telefonenummer', with: '22222222'
#    click_button 'Lagre'
#
#
#    click_link 'Registrer en nytt oppdrag på denne kunden'
#    current_path.should == new_customer_task_path(Customer.last)
#    #save_and_open_page
#    
#
#    # Oppdragstype
#    select 'Maling', from: 'task_task_type_id'
#    select 'Acryl',  from: 'task_paint_id'
#    select 'Josh',   from: 'task_artisan_id'
#    fill_in 'Oppstartsdato', with: '01.05.2014'
#    click_button 'Lagre oppdrag i Visma'
#  end
#end
#
#
