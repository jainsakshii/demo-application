# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_index_path, alert: "You are not access to given page."
  end

  
  
  protected
  
  def after_sign_in_path_for(resource)
    home_index_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:username, :name, :phone, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in,
      keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:username, :name, :email, :password_confirmation, :current_password])
  end

  private 

  # def record_not_found
  #   redirect_to root_path, alert: "Record not found"
  # end

end

