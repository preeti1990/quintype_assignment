class Ride < ApplicationRecord
  belongs_to :seat

  validates :amount, :start_time, :end_time, :otp, :source_location_id, :destination_location_id, :presence => true
  validates :ride_state, inclusion: {in: RIDE_STATE.values}
  validate  :check_seat

  before_create :fill_otp
  after_update  :set_seat_availability


  #If seat is not bookable then not allowing to create new ride for given seat
  def check_seat
     if(self.seat.present? && !self.seat.bookable?)
       errors.add(:seat_id, "seat is not bookable")
     end
  end

  #set the seat availability based on the state of ride taken on given seat
  def set_seat_availability
    if(self.ridestate == RIDE_STATE[:started]) 
      self.seat.bookable = false
    elsif(self.ridestate == RIDE_STATE[:completed] || self.ridestate == RIDE_STATE[:cancelled])
      self.seat.bookable = false
    end
  end

  def self.create(params)
    retry_count = 3
    begin

      #create source and destination location based on source and destination lat-lng

      if(params[:source_lat].blank? || params[:source_lng].blank?)
        raise ArgumentError.new("source location details can't be blank during Ride creation") 
      end

      if(params[:dest_lat].blank? || params[:dest_lng].blank?)
        raise ArgumentError.new("destination location details can't be blank during Ride creation") 
      end

      source_loc_params       = Hash.new
      source_loc_params[:lat] = params[:source_lat]
      source_loc_params[:lng] = params[:source_lng]
      source_loc              = Location.create(source_loc_params)

      dest_loc_params       = Hash.new
      dest_loc_params[:lat] = params[:dest_lat]
      dest_loc_params[:lng] = params[:dest_lng]
      dest_loc              = Location.create(dest_loc_params)

      if(params[:seat_id].blank?)
        raise ArgumentError.new("seat can't be blank during Ride creation") 
      end

      if(params[:start_time].blank?)
        raise ArgumentError.new("start time can't be blank during Ride creation") 
      end

      if(params[:end_time].blank?)
        raise ArgumentError.new("end time can't be blank during Ride creation") 
      end


      if(params[:ride_time].blank?)
        raise ArgumentError.new("ride time can't be blank during Ride creation") 
      end

      ride                         = Ride.new
      ride.seat_id                 = params[:seat_id]
      rise.start_time              = params[:start_time]
      rise.end_time                = params[:end_time]
      ride.amount                  = params[:amount]
      ride.source_location_id      = source_loc.id
      ride.destination_location_id = dest_loc.id
      ride.user_id                 = params[:user_id]
      ride.ride_time               = params[:ride_time]

      dup_ride = ride.duplicate
      if(dup_ride.present?)
        return dup_ride
      end

      if(ride.save)
        return ride
      else
        puts "errors while creating ride #{ride.errors.inspect}"
      end
    rescue ActiveRecord::RecordNotUnique => e
      puts "DEBUG>> exception caught: #{e.message}"
      retry_count -= 1
      retry if retry_count > 0
      return nil
    end
  end

  def update
    self.ride_state     = params[:ride_state]
    self.altered_amount = params[:altered_amount]
    self.save
  end

  def duplicate
    Ride.where("user_id = ? AND seat_id = ? AND date(created_at) >= ? And ride_time = ?", self.user_id, self.seat_id, self.created_at - 5.minutes, self.ride_time).take
  end

  def fill_otp
    self.otp = 4.times.map{rand(10)}.join
  end
end
