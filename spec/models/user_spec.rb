# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           not null
#  roles                  :string           is an Array
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  department_id          :integer
#  mobile                 :integer
#  employee_nr            :string
#  image                  :string
#  emp_id                 :string
#  profession_id          :integer
#  home_address           :string
#  home_area_code         :string
#  home_area              :string
#  roles_mask             :integer
#  gender                 :string
#  address                :string
#  birth_date             :date
#

require 'spec_helper'

describe User do
  before :each do
    @user  = Fabricate(:user)
  end

  it "is valid from the Fabric" do
    expect(@user).to be_valid
  end

  describe 'Roles' do
    it 'default role' do
      expect(@user.roles).to eq [:worker]
    end

    it 'check role' do
      expect(@user.is?('worker')).to eq true
    end

    it 'find users by role' do
      @project_leader = Fabricate(:user, roles: [:project_leader])
      expect(User.with_role(:worker)).to include @user
      expect(User.with_role(:project_leader)).to include @project_leader
    end
  end

  describe 'helpers' do
    before(:all) do
      User.destroy_all
      @martin  = Fabricate(:user,
        first_name: 'Martin', last_name: 'Stabenfeldt')
      @joachim = Fabricate(:user,
        first_name: 'Joachim', last_name: 'Stray')
      @jimmi = Fabricate(:user,
        first_name: 'Jimmi', last_name: 'Stromme')
    end

    it 'initials on names.  1 letter from the first name, 3 from the last name' do
      expect(@martin.initials).to match 'MSTA'
      expect(@joachim.initials).to match 'JSTR'
    end

    it 'fallback solution if taken' do
      expect(@jimmi.initials).to match 'JIST'
    end

    it 'initials on names. Generated when creating new users' do
      expect(@martin.initials).to match 'MSTA'
      expect(@joachim.initials).to match 'JSTR'
    end

  end
  describe 'scopes' do
    before do
      Skill.destroy_all
      @certificate = Fabricate(:certificate)
      @welding = Fabricate(:skill, title: 'welding master')
      @welding.save!
      @user_certificate = Fabricate(:user_certificate, user: @user,
                                   certificate: @certificate)
      @user.skills << @welding
      @user.save!
    end

    it 'with_skill' do
      expect(User.with_skill(@welding)).to include @user
    end

    it 'with_certificate' do
      expect(User.with_certificate(@certificate)).to include @user
    end
  end

  it 'multiple roles' do
    @user.roles= [:worker, :admin]
    @user.save
    expect(@user.roles).to eq [:admin, :worker]
  end

  it "a user can have many tasks" do
    @task = Fabricate(:task)
    @task2 = Fabricate(:task)
    @user.tasks << @task
    @user.tasks << @task2
    expect(@user.tasks).to include(@task, @task2)
  end

  describe 'Departments' do
    before do
      @service = Fabricate(:department, title: 'Service')
      @support = Fabricate(:department, title: 'Support')
      @service_project = Fabricate(:project, user: @user, department: @service)
      @support_project = Fabricate(:project, user: @user, department: @support)
    end

    it 'returns the departments from all projects that the user owns' do
      @user.project_departments.should eq [@service, @support]
    end

  end

  describe 'favorites' do
    before do
      @project = Fabricate(:project)
      @second_project = Fabricate(:project)

      @customer = Fabricate(:customer)
      @second_customer = Fabricate(:customer)

      @user.favorites << [@project.set_as_favorite,
                          @second_project.set_as_favorite]
      @user.favorites << [@customer.set_as_favorite,
                          @second_customer.set_as_favorite]
    end

    it 'user can have more favoured projects' do
      expect(Project.favored_by(@user)).to include @project
      expect(Project.favored_by(@user)).to include @second_project
    end

    it 'user can have more favoured customers' do
      expect(Customer.favored_by(@user)).to include @customer
      expect(Customer.favored_by(@user)).to include @second_customer
    end

    it 'can be removed' do
      @project.unset_favorite(@user)
      @customer.unset_favorite(@user)

      expect(Project.favored_by(@user).count).to eq 1
      expect(Customer.favored_by(@user).count).to eq 1
    end
  end

  describe 'Reports' do
    it 'keeps the latest generated timesheet for
      each project user participates in' do
      @task = Fabricate(:task)
      @task.users << @user
      expect( @user.projects.first).to eq @task.project
      #expect( @user.timesheets.first.title).to eq 'Tak på slottet'
      #expect( @user.timesheets.first.url).to match 'http'
    end
  end


end
