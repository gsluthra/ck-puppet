

$pg_user = "ck_db"
$pg_password = "password"
$pg_database = "ck_db"


class {'postgresql::server': }
->
user { "${pg_user}":
  ensure     => "present",
  managehome => true,
}
->
postgresql::server::db { "${pg_database}":
  user     	=> "${pg_user}",
  password 	=> postgresql_password("${pg_user}","${pg_password}"),
  grant 	=> "all"
}


