#!/bin/bash -x

# Add a postgres9.3 repo
sudo yum --assumeyes localinstall http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm

# Install postgres puppet modules (Run with sudo! so it installs in /etc/puppet/modules)
sudo puppet module install puppetlabs-postgresql

# Run provision puppet script
sudo puppet apply provision.pp