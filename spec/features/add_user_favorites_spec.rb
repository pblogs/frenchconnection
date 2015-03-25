require 'spec_helper'

feature 'User favorites', type: :feature do

  scenario 'user adding favored customer' do
    @user = Fabricate :user, roles: [:project_leader]
    @customer = Fabricate :customer

    sign_in(@user)
    visit edit_customer_path @customer
    check 'Merk som favoritt'
    click_link_or_button 'Lagre'

    visit projects_path
    current_path.should eq projects_path

    within first(:css, '.accordion-tabs-minimal li section ul') do
      expect(page).to have_content 'Kunder'
      expect(page).to have_content @customer.name
    end
  end

  scenario 'user adding favored project' do
    @user = Fabricate :user, roles: [:project_leader]
    @customer = Fabricate :customer
    @project = Fabricate :project, customer: @customer

    sign_in(@user)
    visit edit_customer_project_path(@customer, @project)
    check 'Merk som favoritt'
    click_link_or_button 'Lagre'

    visit projects_path
    current_path.should eq projects_path

    within first(:css, '.accordion-tabs-minimal li section ul') do
      expect(page).to have_content 'Prosjekter'
      expect(page).to have_content @project.name
    end
  end

  scenario 'user removing favored customer' do
    @user = Fabricate :user, roles: [:project_leader]
    @customer = Fabricate :customer
    @user.favorites << @customer.set_as_favorite

    sign_in(@user)
    visit edit_customer_path @customer
    uncheck 'Merk som favoritt'
    click_link_or_button 'Lagre'

    visit projects_path
    current_path.should eq projects_path

    within first(:css, '.accordion-tabs-minimal li section ul') do
      expect(page).not_to have_content 'Kunder'
      expect(page).not_to have_content @customer.name
    end
  end

  scenario 'user removing favored project' do
    @user = Fabricate :user, roles: [:project_leader]
    @customer = Fabricate :customer
    @project = Fabricate :project, customer: @customer
    @user.favorites << @project.set_as_favorite

    sign_in(@user)
    visit edit_customer_project_path(@customer, @project)
    uncheck 'Merk som favoritt'
    click_link_or_button 'Lagre'

    visit projects_path
    current_path.should eq projects_path

    within first(:css, '.accordion-tabs-minimal li section ul') do
      expect(page).not_to have_content 'Prosjekter'
      expect(page).not_to have_content @project.name
    end
  end
end
