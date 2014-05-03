#!/bin/bash -x


# Install puppet modules (Run with sudo! so it installs in /etc/puppet/modules)
sudo puppet module install puppetlabs-postgresql
sudo puppet module install puppetlabs-apache


# Final Report
echo -------------------------------------------------------------------------------
sudo puppet module list
echo -------------------------------------------------------------------------------