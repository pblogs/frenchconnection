class UserPolicy  < ApplicationPolicy
  attr_reader :user, :user_object

  def initialize(user, user_object)
    @user = user
    @user_object = user_object
    #require 'pry'; pry
  end

  def index?
    true
  end

  def hours?
    true
  end


  def search?
    true
  end

  def edit_basic_info?
    @user == @user_object || admin_or_project_leader?
  end

  def update_basic_info?
    @user == @user_object || admin_or_project_leader?
  end

  def register_hours?
    @user == @user_object || admin_or_project_leader?
    true
  end

  def new?
    admin_or_project_leader?
  end

  def create?
    admin_or_project_leader?
  end

  def see_hours?
    user_object == user ||
    admin_or_project_leader?
  end

  def manage_cms?
    user.is?(:editor)
  end

  def update?
    user_object == user ||
    admin_or_project_leader?
  end

  def update_important_parts?
    admin_or_project_leader?
  end

  def edit?
    user_object == user ||
    admin_or_project_leader?
  end

  def timesheets?
    user_object == user ||
    admin_or_project_leader?
  end

  def destroy?
    admin_or_project_leader?
  end

  def certificates?
    admin_or_project_leader?
  end

  def approved_hours?
    true
  end

  def create_certificate?
    admin_or_project_leader?
  end


  def show?
    true
  end

  private
  def admin_or_project_leader?
    user.is?(:project_leader) || user.is?(:admin)
  end

end
