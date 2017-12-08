require 'test_helper'

class CabTest < ActiveSupport::TestCase
  fixtures :cabs

  def test_cab
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
    assert cab1.save
    
    cab1_copy = Cab.find(cab1.id)

    assert_equal cab1.name, cab1_copy.name

    cab1.name = "cab1"
    
    assert cab1.save
    assert cab1.destroy
  end





  test "cabs_count" do
    assert_equal 3, Cab.count
  end

  #test "the truth" do
  #  assert true
  #end

  test 'find' do
    assert_equal 'cab2', cabs(:two).name
  end
end
