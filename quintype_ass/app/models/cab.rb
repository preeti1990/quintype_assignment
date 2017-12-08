class Cab < ApplicationRecord
  has_many :locations, as: :owner, :dependent => :destroy
  
  has_one :media, :as => :owner, :dependent => :destroy
  belongs_to :cab_driver_profile
  belongs_to :service_type
  validates :classie_no, :reg_no, :model, :owner_name, :owner_address, :wheels, :color, :active, :presence => true
  validates :fuel, inclusion: {in: FUEL_TYPE.values}
  validates :permit_type, inclusion: {in: PERMIT_TYPE.values}
  validates :vehicle_type, inclusion: {in: VEHICLE_TYPE.values}


  after_create :create_seats

  def get_current_display_loc
    location                        = self.cab_driver_profile.locations.first
    Geocoder::Configuration.timeout = 15
    display_loc                     = Geocoder.address("#{location.lat}, #{location.lng}")
    return display_loc
  end


  def create_seats
    seats_count = self.no_of_seats.to_i
    (0...seats_count).each do |i|
      seat          = Seat.new
      seat.bookable = true
      seat.cab_id   = self.id
      seat.save
    end
  end
end
