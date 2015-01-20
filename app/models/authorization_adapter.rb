class AuthorizationAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    user.is?('project_leader')
  end
end
