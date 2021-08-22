class Spot < ApplicationRecord

  belongs_to :user
  # ひとまず空でもOK(optional: true)にしてる
  # has_many :overseas_areas, optional: true
  # has_many :overseas_areas
  belongs_to :overseas_area, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # has_many :favorited_users, through: :favorites, source: :user

  # attachment :spot_image
  has_many :spot_images, dependent: :destroy
  accepts_attachments_for :spot_images, attachment: :image

  # 通知機能
  has_many :notifications, dependent: :destroy

  # 地図機能
  # 住所を入れると自動的に緯度・経度を測る
  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  validates :name, presence: true
  validates :introduction, presence: true
  validates :japan_area, presence: true
  # validates :address, presence: true
  validates :spot_images, presence: true

  enum japan_area: {
    北海道: 0,
    東北: 1,
    関東: 2,
    中部: 3,
    近畿: 4,
    四国: 5,
    九州: 6,
    沖縄: 7
  }


	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end



  def self.search(search)
    if search != ""
      # name or addressであいまい検索
      Spot.where(['name LIKE(?) or address LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      # 検索フォームに何も入ってなかったら全て返す
      Spot.all
    end
  end


  # 以下、通知機能
  # いいね通知
    def create_notification_favorite!(current_user)
      # 既に「いいね」されているかを照会
      temp = Notification.where(["visitor_id = ? and visited_id = ? and spot_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
      # 「いいね」で "Notification" が作成されていない場合のみ下記処理を実行
      if temp.blank?
        notification = current_user.active_notifications.new(
          spot_id: id,
          visited_id: user_id,
          action: 'favorite'
        )
        # 自分の投稿に対するいいねの場合は通知済み(checked = true)にする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

  # コメント通知
    # 1
    def create_notification_comment!(current_user, comment_id)
      temp_ids = Comment.select(:user_id).where(spot_id: id) # 1.投稿にコメントしたユーザーIDのリストを取得する
                 .where.not(user_id: current_user.id)        # 2.投稿にコメントしたユーザーIDのリストから自分のコメントは除外する
                 .distinct                                   # 3.重複したユーザーIDは除外する
      temp_ids.each do |temp_id|
        save_notification_comment!(current_user, comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    end

    # 2
    def save_notification_comment!(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        spot_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済み
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end




end
