class Location < ApplicationRecord
  include ActiveModel::Dirty
  belongs_to :owner, polymorphic: true

  geocoded_by :address, :latitude  => :lat, :longitude => :lng
  before_save :fill_fields
  after_validation :geocode, :if => lambda{|obj| obj.street_address_changed? && obj.city_changed? && obj.zipcode_changed?}

  def address
    [city, zipcode, street_address].compact.join(', ')
  end

  def fill_fields
    Geocoder::Configuration.timeout = 15
    g_address                       = Geocoder.address("#{self.lat}, #{self.lng}")
    address_vals                    = g_address.split(" ")
    self.street_address             = g_address 
    self.city                       = address_vals[3]
    self.state                      = address_vals[4]
    self.country                    = address_vals[6]
    self.zipcode                    = address_vals[5].split(",")[0]
  end

  def self.create(params)
    retry_count = 3
    begin
      if(params[:lat].blank?)
        raise ArgumentError.new("lat can't be blank for location creation")
      end

      if(params[:lng].blank?)
        raise ArgumentError.new("lng can't be blank for location creation")
      end

      location     = Location.new
      location.lat = params[:lat]
      location.lng = params[:lng]
      if(location.save)
        return location
      else
        puts("error while saving location #{location.errors.inspect}")
      end
    rescue
      puts "DEBUG>> exception caught: #{e.message}"
      retry_count -= 1
      retry if retry_count > 0
      return nil
    end
  end

  def update
   self.lat = params[:lat] 
   self.lng = params[:lng] 
   self.save
  end
  
end
