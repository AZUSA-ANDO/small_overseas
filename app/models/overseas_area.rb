class OverseasArea < ApplicationRecord

#   belongs_to :spot, optional: true
  # belongs_to :spot
  has_many :spots
  validates :name, presence: true

end
