class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_normal_user, only: %i[update]

  def show
    @user=User.find(params[:id])
    @spots = @user.spots.page(params[:page]).per(10).order('updated_at DESC')

    if user_signed_in? && @user.is_deleted==false
    # roomがcreateされた時に、現在ログインしているユーザーと、「Start DM」を押されたユーザーの両方をEntriesテーブルに記録する必要があるので、
    # whereメソッドでそのユーザーを探している
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          # 既にroomが作成されている場合
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    end
  end



  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

# 退会
  def quit
    user = current_user
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_normal_user
    if @user.email == 'guest@example.com'
      redirect_to edit_user_path(@user.id), alert: 'ゲストユーザーの更新はできません。'
    end
  end

end
