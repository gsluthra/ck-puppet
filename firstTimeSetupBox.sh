#!/bin/bash -x


# Install puppet modules (Run with sudo! so it installs in /etc/puppet/modules)
sudo puppet module install puppetlabs-postgresql
sudo puppet module install puppetlabs-apache

# Add a postgres9.3 repo (todo: Move to puppet manifest)
sudo yum --assumeyes localinstall http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm


# Final Report
echo -------------------------------------------------------------------------------
sudo yum repolist
sudo puppet module list
echo -------------------------------------------------------------------------------