class Message < ApplicationRecord

  # メッセージが空白の時保存しない
  validates :body, presence: true, length: { maximum: 200 }
  belongs_to :user, optional: true
  belongs_to :room

  has_many :notifications, dependent: :destroy

end
