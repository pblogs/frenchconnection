module ApplicationHelper
  def body_id
    "#{controller.controller_name}_#{controller.action_name}"
  end

  def return_users_nr_in_array(array, user: user)
    array.find_index(user)
  end

  def add_remaining_tds(array, user: user)
    array.size - return_users_nr_in_array(@workers, user: user) -1
  end

  def user_roles(user)
    user.roles.collect { |r| I18n.t("roles.#{r}") }.join(', ')
  end

  def nbsp
    "&nbsp;".html_safe
  end

  def pusher_id
    if ENV["PUSHER_URL"].present?
      ENV["PUSHER_URL"].scan(/\/\/(.{20})\:/).flatten.first
    end
  end

  def dictionary_url
    'http://alliero-dictionary.orwapp.com'
  end
end
