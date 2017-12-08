require 'test_helper'

class RideTest < ActiveSupport::TestCase
  fixtures :service_types
  fixtures :cabs
  fixtures :seats
  fixtures :rides
  fixtures :users

  def test_ride
    #create service_type
    service_type1       = ServiceType.new
    service_type1.name  = service_types(:one).name
    service_type1.price = service_types(:one).price
    assert service_type1.save

    #create cab
    cab1                = Cab.new
    cab1.name           = cabs(:one).name
    cab1.classie_no     = cabs(:one).classie_no
    cab1.reg_no         = cabs(:one).reg_no
    cab1.insurance_no   = cabs(:one).insurance_no
    cab1.model          = cabs(:one).model
    cab1.no_of_seats    = cabs(:one).no_of_seats
    cab1.owner_name     = cabs(:one).owner_name
    cab1.owner_address  = cabs(:one).owner_address
    cab1.reg_date       = cabs(:one).reg_date
    cab1.wheels         = cabs(:one).wheels
    cab1.color          = cabs(:one).color
    cab1.active         = cabs(:one).active
    cab1.fuel           = cabs(:one).fuel
    cab1.permit_type    = cabs(:one).permit_type
    cab1.vehicle_type   = cabs(:one).vehicle_type
    cab1.service_type_id = service_type1.id
    assert cab1.save
    
    #create seat
    seat1           = Seat.new
    seat1.cab_id    = cab1.id
    seat1.bookable  = true
    assert seat1.save

    #book seat in a cab against a user
    ride1 = Ride.new
    ride1.ride_time               = rides(:one).ride_time
    ride1.amount                  = rides(:one).amount
    ride1.amount_paid             = rides(:one).amount_paid
    ride1.start_time              = rides(:one).start_time
    ride1.end_time                = rides(:one).end_time
    ride1.source_location_id      = rides(:one).source_location_id
    ride1.destination_location_id = rides(:one).destination_location_id
    ride1.otp                     = rides(:one).otp

    user1       = User.new
    user1.phone = users(:one).phone
    assert user1.save
  
  
    ride1.user_id = user1.id
    ride1.seat_id = seat1.id
    assert ride1.save

    ride1_copy    = Ride.find(ride1.id)
    assert_equal ride1_copy.source_location_id, ride1.source_location_id
    assert ride1.save
    assert ride1.destroy

    assert user1.save
    assert user1.destroy

    assert seat1.save
    assert seat1.destroy

    assert ride1.save
    assert ride1.destroy

    assert service_type1.save
    assert service_type1.destroy
  end

  # test "the truth" do
  #   assert true
  # end
end
