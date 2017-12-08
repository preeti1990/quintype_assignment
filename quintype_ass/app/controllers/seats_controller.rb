class SeatsController < ApplicationController
  #> -----------------------------------------------------------------------
  #> GET /seats
  #> -----------------------------------------------------------------------
  #>
  #> returns complete list of nearest cabs available based on provided source lat, lng
  #>
  #> PARAMETERS:
  #> - source_lat:      float  : mandatory
  #> - source_lng:      float  : mandatory
  #> - dest_lat:        float  : mandatory
  #> - dest_lng:        float  : mandatory
  #> - service_type_id: integer :mandatory(could be either normal or pink service_type_id)
  #>
  #> RETURNS:
  #> {
  #>   'status'       => '200',
  #>   'cabs_data'    => [
  #>     {
  #>       'vehicle_no'        => seat.cab.reg_no,
  #>       'seat_id'           => seat.id
  #>       'current_location'  => seat.cab.cab_current_loc,
  #>       'distance'          => current_distance,
  #>       'type_of_cab_name'  => seat.cab.type_of_cab.name,
  #>       'type_of_cab_id'    => seat.cab.type_of_cab.id
  #>       'fare'              => distance.type_of_cab.price 
  #>     },
  #>   'tot_items'    =>  seat_results[:total]
  #>   ]
  #> }
  

  def index
    json_object = Hash.new
    status      = 200
    json_object = Seat.get_list(params)
    respond_to do |f|
      f.json{render json: json_object, status: status}
    end
  end
end
