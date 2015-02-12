require 'spec_helper'

describe ExcelProjectTools do

  before do
    @project = Fabricate(:project)
    @user1 = Fabricate(:user, first_name: 'John')
    @snekker_profession = Fabricate(:profession, title: 'Snekker')
    @snekker1 = Fabricate(:user, first_name: 'Snekker', last_name: 'Jens',
      profession: @snekker_profession)
    @snekker2 = Fabricate(:user, first_name: 'Snekker', last_name: '2',
      profession: @snekker_profession)
    @task = Fabricate(:task, project: @project)
    @user1.tasks << @task
    @snekker1.tasks << @task
    @snekker2.tasks << Fabricate(:task, project: @project)

    Fabricate(:hours_spent, hour: 10, task: @task, user: @user1 )
    Fabricate(:hours_spent, hour: 10, task: @task, user: @user1 )
    @hours_for_jens = Fabricate(:hours_spent, hour: 19, overtime_50: 50,
                                        task: @task, user: @snekker1 )
  end

  it 'comma separated string with billable hours' do
    @project.update_attribute(:complete, true)
    @hours_for_jens.update_attribute(:of_kind, 'billable')
    snekker = Profession.where(title: 'Snekker')
    ExcelProjectTools.hours_for_users(project: @project, overtime: :hour,
      profession: snekker ).should eq ['19']
    ExcelProjectTools.hours_for_users(project: @project, overtime: :overtime_50,
      profession: snekker ).should eq ['50']
  end


  it %q{returns a comma separated string of names for profession} do
    ExcelProjectTools.user_names(project: @project, 
    profession_title: 'Snekker').should include(@snekker1.name)
  end

  it 'sum_piecework_hours' do
    Fabricate(:hours_spent, piecework_hours: 10, 
              task: @task, user: @user1, project: @project )
    ExcelProjectTools.sum_piecework_hours(project: @project, 
                                          user: @user1 ).should eq 10
  end

  it 'sum_workhours' do
    Fabricate(:hours_spent, piecework_hours: 16, 
              task: @task, user: @user1, project: @project )
    ExcelProjectTools.sum_piecework_hours(project: @project, 
                                          user: @user1 ).should eq 16
  end

  it 'sum_overtime_50' do
    Fabricate(:hours_spent, piecework_hours: 50, 
              task: @task, user: @user1, project: @project )
    ExcelProjectTools.sum_piecework_hours(project: @project, 
                                          user: @user1 ).should eq 50
  end

  it 'sum_overtime_100' do
    Fabricate(:hours_spent, piecework_hours: 100, 
              task: @task, user: @user1, project: @project )
    ExcelProjectTools.sum_piecework_hours(project: @project, 
                                          user: @user1 ).should eq 100
  end

end
