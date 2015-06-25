class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception  

  load_and_authorize_resource unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  private
  def after_sign_in_path_for resource
    current_user.is_admin? ? admin_root_path : root_path
  end

  def admin_user
    unless current_user.is_admin?
      flash[:danger] = t "admin.flash_danger"
      redirect_to root_path
    end
  end
end
