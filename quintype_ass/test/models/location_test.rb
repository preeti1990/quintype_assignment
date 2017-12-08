require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  fixtures :locations
  
  def test_location
    loc1                = Location.new
    loc1.lat            = locations(:one).lat
    loc1.lng            = locations(:one).lng
    loc1.sublocality    = locations(:one).sublocality
    loc1.city           = locations(:one).city
    loc1.state          = locations(:one).state
    loc1.country        = locations(:one).country
    loc1.zipcode        = locations(:one).zipcode
    loc1.street_address = locations(:one).street_address
    loc1.owner_id       = locations(:one).owner_id
    loc1.owner_type     = locations(:one).owner_type
  
    assert loc1.save
    loc1_copy        = Location.find(loc1.id)
    assert_equal loc1_copy.lat, loc1.lat
    puts loc1.errors.inspect
    assert loc1.save
    assert loc1_copy.destroy
    

  end
  # test "the truth" do
  #   assert true
  # end
end
