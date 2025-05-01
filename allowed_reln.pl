allowed_located_on("large_vehicle", "Bridge").

allowed_located_near("ship", "harbor").          
allowed_located_near("small_vehicle", "small_vehicle").
allowed_located_near("helicopter", "plane").
allowed_located_near("small_vehicle", "roundabout").
allowed_located_near("roundabout", "small_vehicle").
allowed_located_near("storage_tank", "harbor").
allowed_located_near("small_vehicle", "tennis_court").
allowed_located_near("small_vehicle", "basketball_court").
allowed_located_near("small_vehicle", "soccer_ball_field").
allowed_located_near("small_vehicle", "Ground_Track_Field").
allowed_located_near("small_vehicle", "baseball_diamond").

allowed_adjacent_to("tennis_court", "basketball_court").  
allowed_adjacent_to("baseball_diamond", "soccer_ball_field").
allowed_adjacent_to("swimming_pool", "Ground_Track_Field").
allowed_adjacent_to("large_vehicle", "small_vehicle").
allowed_adjacent_to("plane", "plane").
