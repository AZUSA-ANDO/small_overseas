# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController


  before_action :reject_user, only: [:create]


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  protected
  # ・if (@user.valid_password?(params[:user][:password])で、入力されたパスワードが正しいことを確認
  # ・(@user.active_for_authentication? == false))で、@userのactive_for_authentication?メソッドがfalseであるかどうかを確認
  # ・上記の2点が当てはまれば、ログインページにリダイレクトし、エラーメッセージを表示

  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
        flash[:error] = "I have withdrawn.(退会済みです)"
        redirect_to new_user_session_path
      end
    else
      flash[:error] = "Please fill in the required fields.(必須項目を入力してください)"
    end
  end



# ここまで

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
