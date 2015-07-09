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

  def update_basic_info?
    @user == @user_object #|| admin_or_project_leader?
    puts "@user_object is #{@user_object.inspect}"
    # ^^  App 84489 stdout: @user_object is :user
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


  def update?
    user_object == user ||
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


  def show?
    true
  end

  private
  def admin_or_project_leader?
    user.is?(:project_leader) || user.is?(:admin)
  end
end
