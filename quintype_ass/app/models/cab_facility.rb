class CabFacility < ApplicationRecord
  belongs_to :cab
  belongs_to :facility
  validates :cab_id, :facility_id, :presence => true
end
