#Technical Stack
Rails 5.0.3
Ruby  2.2.3
Mysql 7.8.20
geocoder
solr



#Issues:- 
1.Right now Fare amount is not coming correct, debugging in process.
2. City filter having some issue, debugging in process.



#assumptions
1. assuming source_lat, source_lng, dest_lat, dest_lng, service_type_id in parameters to show available nearest cabs.
2. for now source_lat, source_lng, dest_lat, dest_lng, service_type_id all are mandatory.


#enhancements
1.For now searching cabs in the city level given by geocoder gem. Ideally we should divide area into custom cities or subcities to search nearest cabs in more relevant available cabs.
2.For now taking only one location of cabdriver ideally we should make new location each time to track cab driver location.
3.Fow now taking only two types of services normal and pink(ServiceTypes)








#structure
controllers:-
#models:-
shown in uml diagram in file named as quin_type_cab.uxf



1.seats_controller.rb
list of available seats

#workflow
1. To create the database
    rake db:create
2. Run all migration
    rake db:migrate
3. Do bundle install to install all dependencies.
4. Run Ruby script file named as quintype_seed.rb. (to load sample data).
5. Test Cases and results:-
#url: - GET/seats
case.1(searching for a normal car in Kumar I-life Apartments) 
  #> - PARAMETERS
  #> - source_lat:   12.929880   
  #> - source_lng:   77.687399   
  #> - dest_lat:     12.965413   
  #> - dest_lng:     77.714836   
  #> - service_type_id:1(normal car) 
  #>
  #> RETURNS:
  #> {
  #>   'status'       => '200',
  #>   'cabs_data'    => [
  #   {
  #      "seat_id": 1,
  #      "vehicle_no": "KA05 PF1454",
  #      "current_location": "24, Devarabisanahalli, Bellandur, Bengaluru, Karnataka 560103, India",
  #      "distance": 0.0013835063582576471,
  #      "type_of_cab_name": "normal",
  #      "type_of_cab_id": 1,
  #      "fare": 0.0013835063582576471
  #    },
  #    {
  #      "seat_id": 5,
  #      "vehicle_no": "KA13 SF9021",
  #      "current_location": "SBM Complex, 1st Main Rd, Aswath Nagar, Marathahalli, Bengaluru, Karnataka 560037, India",
  #      "distance": 2.1160305305634073,
  #      "type_of_cab_name": "normal",
  #      "type_of_cab_id": 1,
  #      "fare": 2.1160305305634073
  #    },
  #    {
  #      "seat_id": 2,
  #      "vehicle_no": "KA04 ST1257",
  #      "current_location": "Purva Riviera Driveway, Lakshminarayana Pura, AECS Layout, Marathahalli, Bengaluru, Karnataka 560037, India",
  #      "distance": 2.399893122717381,
  #      "type_of_cab_name": "normal",
  #      "type_of_cab_id": 1,
  #      "fare": 2.399893122717381
  #    },
  #    {
  #      "seat_id": 3,
  #      "vehicle_no": "KA05 PF1454",
  #      "current_location": "51, 1st Main Rd, HAL 2nd Stage, Kodihalli, Bengaluru, Karnataka 560008, India",
  #      "distance": 3.8333529007610743,
  #      "type_of_cab_name": "normal",
  #      "type_of_cab_id": 1,
  #      "fare": 3.8333529007610743
  #    },
  #    {
  #      "seat_id": 8,
  #      "vehicle_no": "KA03 GF1290",
  #      "current_location": "62, Whitefield Main Rd, Prestige Ozone, Whitefield, Bengaluru, Karnataka 560066, India",
  #      "distance": 4.53473181279513,
  #      "type_of_cab_name": "normal",
  #      "type_of_cab_id": 1,
  #      "fare": 4.53473181279513
  #    },
  #    {
  #      "seat_id": 6,
  #      "vehicle_no": "KA03 SF99008",
  #      "current_location": "23, Hosur Rd, Madiwala, 1st Stage, BTM Layout, Bengaluru, Karnataka 560068, India",
  #      "distance": 4.539198899835918,
  #      "type_of_cab_name": "normal",
  #      "type_of_cab_id": 1,
  #      "fare": 4.539198899835918
  #    },
  #    {
  #      "seat_id": 7,
  #      "vehicle_no": "KA03 SF99008",
  #      "current_location": "23, Hosur Rd, Madiwala, 1st Stage, BTM Layout, Bengaluru, Karnataka 560068, India",
  #      "distance": 4.539198899835918,
  #      "type_of_cab_name": "normal",
  #      "type_of_cab_id": 1,
  #      "fare": 4.539198899835918
  #    },
  #    {
  #      "seat_id": 9,
  #      "vehicle_no": "KA03 SN9089",
  #      "current_location": "98, 18th Cross Rd, Mahadeshwara Nagar, Stage 2, BTM Layout, Bengaluru, Karnataka 560076, India",
  #      "distance": 5.6178082865560475,
  #      "type_of_cab_name": "normal",
  #      "type_of_cab_id": 1,
  #      "fare": 5.6178082865560475
  #    }
  #
  #   ],
  #  "tot_items": 8
  #> }

case: 2(searching for a pink car in Kumar I-Life apartments)
  #> - PARAMETERS
  #> - source_lat:   12.929880   
  #> - source_lng:   77.687399   
  #> - dest_lat:     12.965413   
  #> - dest_lng:     77.714836   
  #> - service_type_id:2 (pink car) 
  #>
  #> RETURNS:
  #> {
  #>   'status'       => '200',
  #>   'cabs_data'    => [
  #{
  #    "seat_id": 17,
  #    "vehicle_no": "KA03 SF4111",
  #    "current_location": "Prestige Tech Park Internal Rd, Kodbisanhalli, Bengaluru, Karnataka 560103, India",
  #    "distance": 0.9863230996071096,
  #    "type_of_cab_name": "pink",
  #    "type_of_cab_id": 2,
  #    "fare": 4.931615498035548
  #  },
  #  {
  #    "seat_id": 12,
  #    "vehicle_no": "KA03 SF9999",
  #    "current_location": "Akamai Technologies India Pvt Ltd, Outer Ring Rd, Green Glen Layout, Bellandur, Bengaluru, Karnataka 560103, India",
  #    "distance": 1.2660687350525879,
  #    "type_of_cab_name": "pink",
  #    "type_of_cab_id": 2,
  #    "fare": 6.33034367526294
  #  },
  #  {
  #    "seat_id": 13,
  #    "vehicle_no": "KA04 SF3333",
  #    "current_location": "5, 6th Cross Rd, Sri Nivasa Reddy Layout, AECS Layout, Marathahalli, Bengaluru, Karnataka 560037, India",
  #    "distance": 2.8317676603917628,
  #    "type_of_cab_name": "pink",
  #    "type_of_cab_id": 2,
  #    "fare": 14.158838301958813
  #  },
  #  {
  #    "seat_id": 14,
  #    "vehicle_no": "KA03 SF1111",
  #    "current_location": "Purvi Meadows, Hoodi Main Rd, Thigalarapalya, Hoodi, Bengaluru, Karnataka 560067, India",
  #    "distance": 4.809738388280076,
  #    "type_of_cab_name": "pink",
  #    "type_of_cab_id": 2,
  #    "fare": 24.048691941400378
  #  },
  #  {
  #    "seat_id": 10,
  #    "vehicle_no": "KA03 SF5555",
  #    "current_location": "64, 6th A Cross Rd, Block 3, Kaveri Nagar, Hongasandra, Bengaluru, Karnataka 560068, India",
  #    "distance": 4.827355705406906,
  #    "type_of_cab_name": "pink",
  #    "type_of_cab_id": 2,
  #    "fare": 24.13677852703453
  #  },
  #  {
  #    "seat_id": 16,
  #    "vehicle_no": "KA03 SF4444",
  #    "current_location": "Whitefield Main Rd, Sathya Sai Layout, Whitefield, Bengaluru, Karnataka 560066, India",
  #    "distance": 5.325712582400239,
  #    "type_of_cab_name": "pink",
  #    "type_of_cab_id": 2,
  #    "fare": 26.628562912001197
  #  },
  #  {
  #    "seat_id": 15,
  #    "vehicle_no": "KA03 UU5474",
  #    "current_location": "Dar Realty Land, SH 35, Prasanth Extension, Whitefield, Bengaluru, Karnataka 560066, India",
  #    "distance": 5.700992161982393,
  #    "type_of_cab_name": "pink",
  #    "type_of_cab_id": 2,
  #    "fare": 28.504960809911964
  #  },
  #  {
  #    "seat_id": 18,
  #    "vehicle_no": "KA03 SF4777",
  #    "current_location": "354, Venkataswamy Naidu Rd, Sampangi Rama Nagar, Bengaluru, Karnataka 560001, India",
  #    "distance": 7.033051293487277,
  #    "type_of_cab_name": "pink",
  #    "type_of_cab_id": 2,
  #    "fare": 35.165256467436386
  #  }
  #
  #   ],
  #  "tot_items": 8
  #> }
  case:3(searching for a normal car in Wonderla area)

  #> PARAMETERS:
  #> - source_lat:  12.834880    
  #> - source_lng:  77.400908
  #> - dest_lat:   12.965413     
  #> - dest_lng:   77.714836     
  #> - service_type_id:1 
  #>

  #> RETURNS:
  #> {
  #>   'status'       => '200',
  #>   'cabs_data'    => [
  #>   ]
  #>   "message"      => "no Cabs available for now",
  #>   'tot_items'    => 0 
  #> }



