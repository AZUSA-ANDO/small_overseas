class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :spots, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :comments, dependent: :destroy
   attachment :profile_image, destroy: false

   validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
   validates :introduction, length: { maximum: 50 }

  # DM機能
   has_many :messages, dependent: :destroy
   has_many :entries, dependent: :destroy

  # フォロー機能
   has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
   has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
   has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
   has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

   # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


   def follow(user_id)
    follower.create(followed_id: user_id)
   end

  # ユーザーのフォローを外す
   def unfollow(user_id)
     follower.find_by(followed_id: user_id).destroy
   end

   # フォローしていればtrueを返す
   def following?(user)
     following_user.include?(user)
   end

  # ログインしている時に退会済みのユーザーを弾く
   def active_for_authentication?
    super && (self.is_deleted == false)
   end



   # フォロー通知
   def create_notification_follow!(current_user)
      temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
      if temp.blank?
        notification = current_user.active_notifications.new(
          visited_id: id,
          action: 'follow'
        )
        notification.save if notification.valid?
      end
   end

end
