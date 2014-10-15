require 'spec_helper'

# this is spec for https://github.com/stabenfeldt/alliero-orwapp/issues/5
feature 'Worker completes a task' do

  scenario 'pending task appears in "my work"" section' do
    @user = Fabricate :user, roles: [:worker]
    @user_task = Fabricate :user_task, user: @user, status: :pending

    sign_in @user
    visit user_path(@user)

    expect(page).to have_css '.my_tasks table tr', count: 1
  end

  scenario 'confirmed task appears in "my work" section' do
    @user = Fabricate :user, roles: [:worker]
    @user_task = Fabricate :user_task, user: @user, status: :confirmed

    sign_in @user
    visit user_path(@user)

    expect(page).to have_css '.my_tasks.worker ul li .actions', count: 1
  end

  scenario 'it no longer appears in "my work" section' do
    @user = Fabricate :user, roles: [:worker]
    @user_task = Fabricate :user_task, user: @user, status: :confirmed

    sign_in @user
    visit user_path(@user)

    page.first(".my_tasks.worker ul li .actions .complete").click

    expect(page).to have_css '.my_tasks.worker ul li .actions', count: 0
  end
end

# TODO move to helper
def sign_in(user)
  visit root_path
  #click_link I18n.t('auth.sign_in.link')
  within '#main' do
    fill_in 'user_mobile',    with: user.mobile
    fill_in 'user_password',  with: 'topsecret'
    click_link_or_button 'Logg inn'
  end
  User.last.mobile.should eq user.mobile
end