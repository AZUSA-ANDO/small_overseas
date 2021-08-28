class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # ログイン先を指定
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_users_path
    when User
      # user_path(resource)
      home_path
    end
  end


  # ログアウト先を指定
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    elsif resource_or_scope == :user
      root_path
    end
  end




  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
