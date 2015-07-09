class ProjectPolicy  < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def index?
    true
  end

  def update?
    admin_or_project_leader?
  end

  def edit?
    admin_or_project_leader?
  end

  def destroy?
    admin_or_project_leader?
  end

  def show?
    true
  end

  def create?
    true
  end

  def billable_hours?
    true
  end

  def personal_hours?
    true
  end

  def daily_report?
    true
  end

  private
  def admin_or_project_leader?
    user.is?(:project_leader) || user.is?(:admin)
  end

end
