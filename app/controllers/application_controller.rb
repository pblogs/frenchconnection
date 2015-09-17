class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :authenticate_user!
  before_action :fetch_settings
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  respond_to :html, :json

  def index
  end

  private

  def user_not_authorized
    redirect_to(request.referrer || root_path)
  end

  def get_paginate_default_field(first_char)
    if first_char.can_be_integer?
      '0-9'
    elsif ('a'..'z').include?(first_char) || ('A'..'Z').include?(first_char)
      first_char
    else
      '*'
    end
  end

  def fetch_settings
    @settings = Setting.get
  end

  def set_current_user
    @current_user ||= current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :mobile]
  end
end
