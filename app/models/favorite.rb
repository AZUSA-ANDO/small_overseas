class Favorite < ApplicationRecord

  belongs_to :user
	belongs_to :spot

# 	1つの投稿に対して１つのいいねしかできないようにする
	validates_uniqueness_of :spot_id, scope: :user_id


end
