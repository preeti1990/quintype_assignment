require 'test_helper'

class CabDriverProfileTest < ActiveSupport::TestCase
  fixtures :cab_driver_profiles
  # test "the truth" do
  #   assert true
  # end

  def test_cab_driver 
    cab_driver                     = CabDriverProfile.new
    cab_driver.name                = cab_driver_profiles(:one).name
    cab_driver.phone               = cab_driver_profiles(:one).phone
    cab_driver.otp                 = cab_driver_profiles(:one).otp
    cab_driver.avg_user_rating     = cab_driver_profiles(:one).avg_user_rating
    cab_driver.experience          = cab_driver_profiles(:one).experience
    cab_driver.driving_liscence_no = cab_driver_profiles(:one).driving_liscence_no
    cab_driver.aadhar_no           = cab_driver_profiles(:one).aadhar_no
    cab_driver.verified            = cab_driver_profiles(:one).verified
    assert cab_driver.save
    cab_driver_copy = CabDriverProfile.find(cab_driver.id)

    assert_equal cab_driver.name, cab_driver_copy.name

    cab_driver.name = "Mohan"
    
    assert cab_driver.save
    assert cab_driver.destroy
  end
end
