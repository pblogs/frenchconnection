require 'spec_helper'

require 'sidekiq/testing'
Sidekiq::Testing.inline!

# this is spec for https://github.com/stabenfeldt/alliero-orwapp/issues/6
feature 'Project leader completes a project' do

  scenario 'workers are notified'  do
    @user      = Fabricate :user, roles: [:project_leader]
    @project   = Fabricate :project
    @worker    = Fabricate :user, roles: [:worker]
    @task      = Fabricate :task, project: @project
    @user_task = Fabricate :user_task, user: @worker, task: @task

    sign_in @user

    visit customer_project_path(@project.customer, @project)
    Sms.should_receive(:send_msg).with(hash_including(to: "47#{@worker.mobile}"))
    expect { page.first('.action_buttons a.complete').click }
      .to change(Project.where(complete: true), :count).by(1)

  end
end


