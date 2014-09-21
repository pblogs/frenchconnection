module TasksHelper

  def task_needs_reporting(task)
    # TODO just a placeholder logic
    task.project.complete && task.hours_spents.where(user: current_user).count == 0
  end

end
