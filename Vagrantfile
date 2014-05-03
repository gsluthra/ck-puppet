# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  ###############################
  # MY CENTOS VAGRANT FILE
  ###############################
  
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos-6.4-minimal-fresh"

  config.vm.define "CK-Vag-Centos" do |myvag|
  end

  config.vm.network :private_network, ip: "192.168.33.10"
  # config.vm.network :public_network
  config.ssh.username = "vagrant"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 3092, "--cpus", 2, "--name", "Vagrant_CK"]
  end

  
  config.vm.provision "shell", path: "firstTimeSetupBox.sh"
  
  #config.vm.provision "puppet" do |puppet|
  #  puppet.manifests_path = ""
  #  puppet.manifest_file = "provision.pp"
  #end

  
end
