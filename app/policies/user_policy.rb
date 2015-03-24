class UserPolicy  < ApplicationPolicy
  attr_reader :user

  def initialize(user, user_object)
    @user = user
    @user_object = user_object
  end

  def index?
    true
  end

  def update_basic_info?
    @user == @user_object || user.is?(:admin)
  end

  def new?
    user.is?(:project_leader) || user.is?(:admin)
  end

  def create?
    user.is?(:project_leader) || user.is?(:admin)
  end

  def update?
    user.is?(:project_leader) || user.is?(:admin)
  end

  def edit?
    user.is?(:project_leader) || user.is?(:admin)
  end

  def destroy?
    user.is?(:project_leader) || user.is?(:admin)
  end


  def show?
    true
  end

end
