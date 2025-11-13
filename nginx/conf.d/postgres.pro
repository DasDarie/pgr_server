location /pro {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass pgr;

	postgres_escape		$ses $arg_ses;
	postgres_escape		$ann $arg_ann;

	postgres_query		GET	"select fn_pro_one($ses, $ann)";
	postgres_rewrite	GET	no_rows 410;
}
location /pros {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass pgr;

	postgres_escape		$ses $arg_ses;
	postgres_escape		$ord $arg_ord;
	postgres_escape		$dir $arg_dir;
	postgres_escape		$row $arg_row;
	postgres_escape		$pag $arg_pag;

	postgres_query		GET	"select fn_pro_all($ses, $ord, $dir, $row, $pag)";
	postgres_rewrite	GET	no_rows 410;
}

location /pros/p {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass pgr;

	postgres_escape		$ses $arg_ses;
	postgres_escape		$ann $arg_ann;

	postgres_query		GET	"select fn_pro_like($ses, $ann, 'PROS')";
	postgres_rewrite	GET	no_rows 410;
}
location /pros/v {
	add_header content-type "application/json";
	include /etc/nginx/conf.d/cors.cnf;
	postgres_output text;
	postgres_pass pgr;

	postgres_escape		$ses $arg_ses;
	postgres_escape		$ann $arg_ann;

	postgres_query		GET	"select fn_pro_like($ses, $ann, 'VENT')";
	postgres_rewrite	GET	no_rows 410;
}
