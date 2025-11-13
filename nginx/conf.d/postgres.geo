location /geo/getContourCommune {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass geo;
	rds_json off;

	postgres_escape		$sessID $arg_sessionID;
	postgres_escape		$insee $arg_insee;
	postgres_query HEAD GET "SELECT fn_getContourCommune($sessID, $insee);";
	error_page 405 = $request_uri;
}

location /geo/getListeCommunes {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass geo;
	rds_json off;

	postgres_escape		$sessID $arg_sessionID;
	postgres_query HEAD GET "SELECT fn_getcommuneslist($sessID);";
	error_page 405 = $request_uri;
}

location /geo/getParcellesByInsee {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass geo;
	rds_json off;

	postgres_escape		$sessID $arg_sessionID;
	postgres_escape		$insee $arg_insee;
	postgres_escape		$minSurf $arg_surf_min;
	postgres_escape		$maxSurf $arg_surf_max;
	postgres_query HEAD GET "SELECT fn_getparcellesbyinsee($sessID, $minSurf, $maxSurf, $insee);";
	error_page 405 = $request_uri;
}

location /geo/getParcellesInBox {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass geo;
	rds_json off;

	postgres_escape		$sessID $arg_sessionID;
	postgres_escape		$minSurf $arg_surf_min;
	postgres_escape		$maxSurf $arg_surf_max;
	postgres_escape		$tl_lat $arg_tl_lat;
	postgres_escape		$tl_lon $arg_tl_lon;
	postgres_escape		$br_lat $arg_br_lat;
	postgres_escape		$br_lon $arg_br_lon;
	postgres_query HEAD GET "SELECT fn_getparcellesinbox($sessID, $minSurf,$maxSurf,$tl_lat, $tl_lon, $br_lat, $br_lon);";
	error_page 405 = $request_uri;
}

location /geo/getParcellesInPoly {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass geo;
	rds_json off;

	postgres_escape		$sessID $arg_sessionID;
	postgres_escape		$minSurf $arg_surf_min;
	postgres_escape		$maxSurf $arg_surf_max;
	postgres_escape		$jsn $arg_jsn;
	postgres_query POST "select fn_getparcellesinpoly($sessID, $minSurf, $maxSurf, $jsn)";
	postgres_rewrite GET no_rows 410;
}

location /geo/getAddress {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass geo;
	rds_json off;

	postgres_escape		$postcode $arg_postcode;
	postgres_escape		$city_name $arg_city_name;
	postgres_escape		$address $arg_address;
	postgres_query HEAD GET "SELECT fn_suggest_addresses($postcode, $city_name, $address);";
}

location /geo/getInsee {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass geo;
	rds_json off;

	postgres_escape		$sessID $arg_sessionID;
	postgres_escape		$postcode $arg_postcode;
	postgres_escape		$city_name $arg_city;
	postgres_query HEAD GET "SELECT fn_get_insee($sessID, $postcode, $city_name);";
	error_page 405 = $request_uri;
}
