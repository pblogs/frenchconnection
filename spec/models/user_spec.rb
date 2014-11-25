# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  encrypted_password     :string(255)      not null
#  roles                  :string(255)      is an Array
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  department_id          :integer
#  mobile                 :integer
#  employee_nr            :string(255)
#  image                  :string(255)
#  emp_id                 :string(255)
#  profession_id          :integer
#  home_address           :string(255)
#  home_area_code         :string(255)
#  home_area              :string(255)
#

require 'spec_helper'

describe User do
  before :each do
    @user  = Fabricate(:user)
  end

  it "is valid from the Fabric" do
    expect(@user).to be_valid
  end

  it "a user can have many tasks" do
    @task = Fabricate(:task)
    @task2 = Fabricate(:task)
    @user.tasks << @task
    @user.tasks << @task2
    expect(@user.tasks).to include(@task, @task2)
  end

  describe 'project_departments' do
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

end
