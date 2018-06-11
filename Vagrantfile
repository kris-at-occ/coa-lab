# -*- mode: ruby -*-
# vi: set ft=ruby :
servers=[
  {
    :hostname => "coa-lab",
    :box => "ubuntu/xenial64",
    :ram => 8192,
    :cpu => 2,
    :script => "sh /vagrant/devstack_setup.sh"
  }
]
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
# Configure VM's second NIC either with Vagrant 'public_network' - i.e. bridged interface (uncomment line 22 - below), or with 'host only' network (uncomment line 26)
      node.vm.network "public_network"
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", machine[:ram], "--cpus", machine[:cpu]]
# Configure VM's second NIC either with Vagrant 'public_network' - i.e. bridged interface (uncomment line 22), or with 'host only' network (uncomment line 26 - below)
#        vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
      end
      node.vm.provision "shell", inline: machine[:script], privileged: true, run: "once"
    end
  end
end
