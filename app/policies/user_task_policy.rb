class UserTaskPolicy  < ApplicationPolicy

  attr_reader :user, :user_task

  def initialize(user, user_task)
    @user = user
    @user_task = user_task
  end

  def confirm_user_task?
    user_task.user == user
  end
end
