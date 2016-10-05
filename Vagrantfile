# -*- mode: ruby -*-
# vi: set ft=ruby :

$install_consul_script = <<SCRIPT

CONSUL_VERSION=0.7.0

yum install curl unzip wget bind-utils -y

wget -P /tmp https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
wget -P /tmp https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip

unzip /tmp/consul_${CONSUL_VERSION}_linux_amd64.zip -d /opt/consul_${CONSUL_VERSION}_linux_amd64
unzip /tmp/consul_${CONSUL_VERSION}_web_ui.zip -d /opt/consul_${CONSUL_VERSION}_web_ui

ln -sf /opt/consul_${CONSUL_VERSION}_linux_amd64/consul /usr/bin/consul

mkdir -p /etc/consul.d/
mkdir -p /var/log/consul/
chmod a+w /etc/consul.d/ /var/log/consul/

SCRIPT

$install_vault_script = <<SCRIPT

VAULT_VERSION=0.6.1

yum install curl unzip wget bind-utils -y

wget -P /tmp https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip

unzip /tmp/vault_${VAULT_VERSION}_linux_amd64.zip -d /opt/vault_${VAULT_VERSION}_linux_amd64

ln -sfn /opt/vault_${VAULT_VERSION}_linux_amd64/vault /usr/bin/vault

SCRIPT

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false

  box_name = 'opscode_centos-7.2_chef-provisionerless'
  config.vm.box = box_name
  config.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/' \
  "vagrant/virtualbox/#{box_name}.box"

  config.vm.define 'server_1' do |server_1|
    server_1.vm.network :private_network, ip: '192.168.33.35'

    server_1.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    server_1.vm.provision 'shell', inline: $install_consul_script
    server_1.vm.provision 'shell', inline: $install_vault_script

    server_1.vm.provision(
      'shell',
      inline: 'consul agent -server -bootstrap-expect 5 -data-dir /tmp/consul' \
      ' -node=server-one -bind=192.168.33.35 -config-dir /etc/consul.d' \
      ' > /var/log/consul/consul.log 2>&1 &'
    )
  end

  config.vm.define 'server_2' do |server_2|
    server_2.vm.network :private_network, ip: '192.168.33.36'

    server_2.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    server_2.vm.provision 'shell', inline: $install_consul_script

    server_2.vm.provision(
      'shell',
      inline: 'consul agent -server -data-dir /tmp/consul' \
      ' -node=server-two -bind=192.168.33.36 -config-dir' \
      ' /etc/consul.d -join 192.168.33.35 > /var/log/consul/consul.log 2>&1 &'
    )
  end

  config.vm.define 'server_3' do |server_3|
    server_3.vm.network :private_network, ip: '192.168.33.37'

    server_3.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    server_3.vm.provision 'shell', inline: $install_consul_script

    server_3.vm.provision(
      'shell',
      inline: 'consul agent -server -data-dir /tmp/consul' \
      ' -node=server-three -bind=192.168.33.37 -config-dir' \
      ' /etc/consul.d -join 192.168.33.36 > /var/log/consul/consul.log 2>&1 &'
    )
  end

  config.vm.define 'server_4' do |server_4|
    server_4.vm.network :private_network, ip: '192.168.33.38'

    server_4.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    server_4.vm.provision 'shell', inline: $install_consul_script

    server_4.vm.provision(
      'shell',
      inline: 'consul agent -server -data-dir /tmp/consul' \
      ' -node=server-four -bind=192.168.33.38 -config-dir' \
      ' /etc/consul.d -join 192.168.33.37 > /var/log/consul/consul.log 2>&1 &'
    )
  end

  config.vm.define 'server_5' do |server_5|
    server_5.vm.network :private_network, ip: '192.168.33.39'

    server_5.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    server_5.vm.provision 'shell', inline: $install_consul_script

    server_5.vm.provision(
      'shell',
      inline: 'consul agent -server -data-dir /tmp/consul' \
      ' -node=server-five -bind=192.168.33.39 -config-dir' \
      ' /etc/consul.d -join 192.168.33.38 > /var/log/consul/consul.log 2>&1 &'
    )
  end

  config.vm.define 'agent_1' do |agent_1|
    agent_1.vm.network :private_network, ip: '192.168.33.40'

    agent_1.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    agent_1.vm.provision 'shell', inline: $install_consul_script

    agent_1.vm.provision(
      'shell',
      inline: 'consul agent -data-dir /tmp/consul' \
      ' -node=agent-one -bind=192.168.33.40 -config-dir' \
      ' /etc/consul.d -join 192.168.33.35 > /var/log/consul/consul.log 2>&1 &'
    )
  end
end
