class CabDriverProfile < ApplicationRecord
  validates :driving_liscence_no, :aadhar_no, :verified, :presence => true
  has_one :media, :as => :owner, :dependent => :destroy
  has_many :locations, as: :owner, :dependent => :destroy
end
