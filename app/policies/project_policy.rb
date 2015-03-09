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
    project.user == user
  end

  def edit?
    project.user == user
  end

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    project.user == user
  end
end
