class Comment < ApplicationRecord

  belongs_to :user
	belongs_to :spot
	validates :opinion, presence: true

end
