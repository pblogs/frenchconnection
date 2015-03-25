require 'spec_helper'

# this is spec for https://github.com/stabenfeldt/alliero-orwapp/issues/5
feature 'Worker completes a task',  type: :feature do

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

  scenario 'completed task appears in "my work completed" section' do
    @user = Fabricate :user, roles: [:worker]
    @user_task = Fabricate :user_task, user: @user, status: :confirmed

    sign_in @user
    visit user_path(@user)

    page.first(".my_tasks.worker ul li .actions .complete").click

    expect(page).to have_css '.my_tasks.worker.completed ul li', count: 1
  end
end
