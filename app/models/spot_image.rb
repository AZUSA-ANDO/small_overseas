class SpotImage < ApplicationRecord
  belongs_to :spot
  attachment :image
end
