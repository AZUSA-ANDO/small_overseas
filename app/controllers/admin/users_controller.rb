class Admin::UsersController < ApplicationController
    before_action :authenticate_admin!
    layout "admin"

      def index
        @users = User.page(params[:page]).reverse_order
      end

      def show
        @user = User.find(params[:id])
      end

      def edit
        @user = User.find(params[:id])
      end

      def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to admin_user_path(@user)
      end


    private

       def user_params
         	params.require(:user).permit(:name, :introduction, :profile_image, :email, :is_deleted)
       end


end
