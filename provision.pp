

$pg_user       = "ck_db"
$pg_password   = "password"
$pg_database   = "ck_db"
$ck_web_folder = "ck_web"
$ck_web_owner  = "vagrant"
$os_path       = "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin"

### POSTGRES #######

exec { "pgdg93":
	 command  => "sudo yum --assumeyes localinstall http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm",
	 path     => "${os_path}",
	 creates  => "/etc/yum.repos.d/pgdg-93-centos.repo"
} ->
class {'postgresql::server': 
} ->
user { "${pg_user}":
  ensure     => present,
  managehome => true,
} ->
postgresql::server::db { "${pg_database}":
  user     	=> "${pg_user}",
  password 	=> postgresql_password("${pg_user}","${pg_password}"),
  grant 	=> all
}

# Another way of sequencing the stuff.
# Exec["pgdg93"] -> Class['postgresql::server'] -> User["${pg_user}"] -> Postgresql::Server::Db["${pg_database}"] 


### APACHE HTTPD #######

class {'apache': }
->
apache::vhost { "localhost":
      port          => "80",
      docroot       => "/var/www/${ck_web_folder}",
      docroot_owner => "${ck_web_owner}",
      docroot_group => "${ck_web_owner}",
} -> 
file { "/var/www/html/index.html":
	ensure   => present,
	owner    => "${ck_web_owner}",
	content  => "<h1> Hello World. Welcome to Apache Web Server </h1>.",
} 

### FIRE WALL ##########
 
exec { "open-port-80":
	 command  => "sudo iptables -I INPUT 5 -m state --state NEW -p tcp --dport 80 -j ACCEPT",
	 path     => "${os_path}",
	 unless   => "sudo iptables-save | grep 80 | grep INPUT | grep ACCEPT | grep NEW | wc -l | xargs test 1 -eq",
	 notify   => Exec["ip-tables-save"]
}

exec { "ip-tables-save":
	 command     => "sudo service iptables save",
	 refreshonly => true,
	 path        => "${os_path}",
}
