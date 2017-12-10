class Seat < ApplicationRecord
  belongs_to :cab
  validates :cab_id, :presence => true

  def bookable?
    return self.bookable
  end


  #returns all the nearby cabs based on provided lat, lng
  def self.get_list(params)
    return if(params[:source_lat].blank? || params[:source_lng].blank?)
    ret_hsh      = Hash.new
    cabs_items   = Array.new
    seat_results = self.solr_seat_search_results(params)
    results      = seat_results[:results]
    #TODO:: make required dao in order to show all the info related to one cab(seat)
    results.each do |result|
      cab_details       = Hash.new
      cab_current_display_loc   = result.cab.get_current_display_loc
      cab_current_loc   = result.cab.cab_driver_profile.locations.first
      type_of_cab       = result.cab.service_type
      current_distance  = Geocoder::Calculations.distance_between([params[:source_lat], params[:source_lng]], [cab_current_loc.lat, cab_current_loc.lng]) 
      #get distance between 2 points by using geocoder gem
      distance          = Geocoder::Calculations.distance_between([params[:source_lat], params[:source_lng]], [params[:dest_lat], params[:dest_lng]])
      fare              = (current_distance * (type_of_cab.price)).to_f

      cab_details = {seat_id:result.id, vehicle_no: result.cab.reg_no,current_location: cab_current_loc.street_address,distance: current_distance,type_of_cab_name: type_of_cab.name, type_of_cab_id: type_of_cab.id,fare: fare}
      cabs_items.push(cab_details)
    
    end
    ret_hsh[:cabs_data] = cabs_items
    if(cabs_items.count == 0) 
      ret_hsh[:message] = "no Cabs available for now"
    end
    ret_hsh[:tot_items] = seat_results[:total]
    puts JSON.pretty_generate(ret_hsh)
    return ret_hsh
  end

  def self.solr_seat_search_results(params)
    radius       = params[:radius].present? ? params[:radius] : 10
    ret_hsh      = Hash.new
    seat_results = Seat.search do
      #TODO::Cab locality need to considered
      Geocoder::Configuration.timeout = 15
      g_address                       = Geocoder.address("#{params[:source_lat]}, #{params[:source_lng]}")
      address_vals                    = g_address.split(" ")
      req_city                        = address_vals[3].split(",")[0].strip
      puts "req city value is #{req_city}"
      with(:cab_city, req_city)

      #Seat should be available for booking 
      with :bookable, true
      #with :assigned_to_cab_driver, true

      #User want a normal or pink cab
      with :service_type_id, params[:service_type_id].to_i if(params[:service_type_id].present?)
      
      #searching cabs within the bounding box formed by params[:lat], params[:lng] and params[:radius]
      if (params[:source_lat].present? && params[:source_lng].present?)
        puts "DEBUG>>> inside condition #{params[:source_lat]}=-------- #{params[:source_lat]}"
        with(:location).in_radius(params[:source_lat],params[:source_lng], radius, :bbox => true)
      end

      ##Ordering by the closest to params[:lat], params[:lng]
      order_by_geodist(:location, params[:source_lat], params[:source_lng])
    end

    ret_hsh[:results]     = seat_results.results
    ret_hsh[:count]       = seat_results.total
    ret_hsh[:total]       = seat_results.total
    return ret_hsh
  end

  def loc_city
    return "" if(self.cab.cab_driver_profile.locations.first.blank?)
    g_address       = Geocoder.address("#{self.cab.cab_driver_profile.locations.first.lat}, #{self.cab.cab_driver_profile.locations.first.lng}")
    address_vals    = g_address.split(",")
    city            = address_vals[address_vals.length - 3].split(",")[0].strip
    return city
  end

  def cab_driver_assigned?
    return self.cab.cab_driver_profile_id.present?
  end

  def cab_service_type_id
    self.cab.service_type_id
  end

  searchable do
    integer :service_type_id, :using => :cab_service_type_id
    boolean :bookable
    boolean :assigned_to_cab_driver , :using => :cab_driver_assigned?
    string  :cab_city, :using => :loc_city
    latlon(:location) {
      Sunspot::Util::Coordinates.new(self.cab.cab_driver_profile.locations.first.lat, self.cab.cab_driver_profile.locations.first.lng) 
    }
  end

end
