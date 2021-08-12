class Spot < ApplicationRecord

  belongs_to :user
  # ひとまず空でもOK(optional: true)にしてる
  belongs_to :overseas_areas, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :spot_image


  validates :name, presence: true
  validates :introduction, presence: true
  validates :japan_area, presence: true
  validates :address, presence: true
  validates :spot_image, presence: true

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


end
