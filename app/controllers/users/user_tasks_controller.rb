module Users
  class UserTasksController < ApplicationController
    def confirm_user_task
      @user = User.find(params[:user_id])
      @user_task = @user.user_tasks.where(task_id: params[:task_id]).first
      @user_task.confirm!
      redirect_to @current_user, 
        notice: I18n.t('task.confirmed')
    end
  end
end
