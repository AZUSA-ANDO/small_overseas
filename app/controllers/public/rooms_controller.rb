class Public::RoomsController < ApplicationController

before_action :authenticate_user!

  def create
    @room = Room.create
    # @entry1はログインしているユーザー（EntriesテーブルにRoom.createで作成された@roomにひもづくidと、現在ログインしているユーザーのidを保存させる）
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    # @entry2ではフォローされている側の情報をEntriesテーブルに保存する
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    # createと同時に、チャットルームが開く
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    # Entriesテーブルに現在ログインしているユーザーのidとそれにひもづいたチャットルームのidをwhereメソッドで探し、そのレコードがあるか確認
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      # Messageテーブルにそのチャットルームのidと紐づいたメッセージを表示させる(新しいメッセージが上に)
      @messages = @room.messages.order(created_at: :desc).page(params[:page]).per(50)
      # 新しくメッセージを作成する場合は、メッセージのインスタンスを生成する
      @message = Message.new
      # ユーザーの名前などの情報を表示させるために、@room.entriesを@entriesというインスタンス変数に入れ、Entriesテーブルのuser_idの情報を取得
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
