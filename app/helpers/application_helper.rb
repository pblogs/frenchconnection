module ApplicationHelper
  def body_id
    "#{controller.controller_name}_#{controller.action_name}"
  end
end
