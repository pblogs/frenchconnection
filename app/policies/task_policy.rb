class TaskPolicy  < ApplicationPolicy
  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
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
    task.user == user ||
    admin_or_project_leader?
  end

  def select_inventory?
    task.user == user ||
    admin_or_project_leader?
  end

  def show?
    true
  end

  def create?
    admin_or_project_leader?
  end

  def inventories?
    true
  end

  def complete?
    task.user == user ||
    admin_or_project_leader?
  end

  private
  def admin_or_project_leader?
    user.is?(:project_leader) || user.is?(:admin)
  end

end
