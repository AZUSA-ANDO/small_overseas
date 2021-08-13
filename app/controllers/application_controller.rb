class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # ログイン先を指定

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_users_path
    when User
      user_path(resource)
    end
  end


  # def after_sign_in_path_for(resource)
  #   user_path(resource)
  # end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
