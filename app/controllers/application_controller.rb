# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_index_path, alert: "You are not access to given page."
  end
  protected
  def after_sign_in_path_for(resource)
    home_index_path
  end
end

