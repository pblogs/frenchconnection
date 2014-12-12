require 'spec_helper'

feature 'Active Admin' do
  scenario 'project leader can access dashboard' do
    @project_leader = Fabricate(:user, roles: [:project_leader])
    sign_in(@project_leader)

    visit '/admin'

    within first(:css, '.header #current_user') do
      expect(page).to have_content @project_leader.name
    end
  end

  scenario 'worker cannot access dashboard' do
    @worker = Fabricate(:user, roles: [:worker])
    sign_in(@worker)

    visit '/admin'

    current_path.should eq '/'
  end
end
