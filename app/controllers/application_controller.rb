class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :set_timezone

  before_action :configure_permitted_parameters, if: :devise_controller?

  # cancan hacks..
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end 

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :yubiotp
  end

  def set_timezone
    Time.zone = cookies["jstz_time_zone"]
  end
end
