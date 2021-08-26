class Comment < ApplicationRecord

belongs_to :user
belongs_to :spot
validates :opinion, presence: true, length: { maximum: 100 }
has_many :notifications, dependent: :destroy

end
