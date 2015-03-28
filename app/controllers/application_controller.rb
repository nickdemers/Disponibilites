class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DisponibilitesHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  #rescue_from CanCan::AccessDenied do |exception|
  #  flash[:error] = "Access denied!"
  #  redirect_to root_url
  #end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
  end
end