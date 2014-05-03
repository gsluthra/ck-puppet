

$pg_user       = "ck_db"
$pg_password   = "password"
$pg_database   = "ck_db"
$ck_web_folder = "ck_web"
$ck_web_owner   = "vagrant"


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


class {'apache': }
->
apache::vhost { "localhost":
      port          => "80",
      docroot       => "/var/www/${ck_web_folder}",
      docroot_owner => "${ck_web_owner}",
      docroot_group => "${ck_web_owner}",
}
-> 
file { "/var/www/html/index.html":
	ensure => "present",
	owner  => "${ck_web_owner}",
	content => "<h1> Hello World. Welcome to Apache Web Server </h1>.",
}


