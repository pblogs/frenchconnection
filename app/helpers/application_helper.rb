module ApplicationHelper
  def body_id
    "#{controller.controller_name}_#{controller.action_name}"
  end

  def return_users_nr_in_array(array, user: user)
    array.find_index(user)
  end
end
