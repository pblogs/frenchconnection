class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  before_action :set_current_user
  before_action :authenticate_user!

  def set_current_user
    @current_user ||= current_user
  end

  def frontpage
    redirect_to select_frontpage
  end

  def after_sign_in_path_for(resource)
    select_frontpage
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end

  def select_frontpage
    if @current_user.has_role? :worker
      user_path(@current_user)
    elsif @current_user.has_role? :project_leader
      frontpage_manager_path
    end
  end

end
