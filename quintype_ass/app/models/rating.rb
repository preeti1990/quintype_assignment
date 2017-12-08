class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  validates :user_id, :ride_id, :presence => true
end
