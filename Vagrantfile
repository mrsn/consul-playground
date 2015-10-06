# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT

sudo apt-get update && apt-get install curl unzip -y

wget -P /tmp https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip
wget -P /tmp https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip

sudo unzip /tmp/0.5.2_linux_amd64.zip -d /opt/consul-0.5.2_linux_amd64
sudo unzip /tmp/0.5.2_web_ui -d /opt/consul-0.5.2_linux_amd64/web_ui

sudo ln -sf /opt/consul-0.5.2_linux_amd64/consul /usr/bin/consul

sudo mkdir -p /etc/consul.d
sudo chmod a+w /etc/consul.d

SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provision "shell", inline: $script

  config.vm.define "node_1" do |node_1|
    node_1.vm.box = "opscode_ubuntu-14.04_provisionerless"
    node_1.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

    node_1.vm.network :private_network, ip: "192.168.33.35"
    node_1.vm.hostname = "node1"

    node_1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  end

  config.vm.define "node_2" do |node_2|
    node_2.vm.box = "opscode_ubuntu-14.04_provisionerless"
    node_2.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

    node_2.vm.hostname = "node2"
    node_2.vm.network :private_network, ip: "192.168.33.36"

    node_2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  end


  config.vm.define "node_3" do |node_3|
    node_3.vm.box = "opscode_ubuntu-14.04_provisionerless"
    node_3.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

    node_3.vm.network :private_network, ip: "192.168.33.37"
    node_3.vm.hostname = "node3"

    node_3.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  end
end
