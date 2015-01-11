# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "CentOS-6.6"
  config.vm.box_url = "https://vagrantcloud.com/chef/boxes/centos-6.6/versions/1.0.0/providers/virtualbox.box"

  config.vm.provider :virtualbox do |vb|
    vb.name = "expect command getting started"
  end

  config.vm.define :web1 do |web|
    web.vm.network :private_network, ip: "192.168.33.110"
    web.vm.provision :shell, :path => "script/install/root/bootstrap.sh"
    web.vm.provision :shell, :path => "script/install/vagrant/bootstrap.sh",privileged: false
  end
end
