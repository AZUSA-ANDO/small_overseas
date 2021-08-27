class Public::NotificationsController < ApplicationController
before_action :authenticate_user!

def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    # 未確認の通知を取り出した後、確認済みにする
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
end


end
