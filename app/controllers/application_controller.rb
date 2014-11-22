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


  def index
  end

  private
  def get_paginate_default_field(first_char)
    if first_char.can_be_integer?
      '0-9'
    elsif ('a'..'z').include?(first_char) || ('A'..'Z').include?(first_char)
      first_char
    else
      '*'
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :mobile]
  end


end
