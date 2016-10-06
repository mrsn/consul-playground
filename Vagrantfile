# -*- mode: ruby -*-
# vi: set ft=ruby :

$install_consul_script = <<SCRIPT

yum install curl unzip wget bind-utils -y docker

service docker restart

SCRIPT

$install_vault_script = <<SCRIPT

VAULT_VERSION=0.6.1

yum install curl unzip wget bind-utils -y

wget -P /tmp https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip

unzip /tmp/vault_${VAULT_VERSION}_linux_amd64.zip -d /opt/vault_${VAULT_VERSION}_linux_amd64

ln -sfn /opt/vault_${VAULT_VERSION}_linux_amd64/vault /usr/bin/vault

SCRIPT

VAGRANTFILE_API_VERSION = '2'
CONSUL_VERSION = 'v0.7.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false

  box_name = 'opscode_centos-7.2_chef-provisionerless'
  config.vm.box = box_name
  config.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/' \
  "vagrant/virtualbox/#{box_name}.box"

  config.vm.define 'server_1' do |server_1|
    server_1.vm.network :private_network, ip: '192.168.33.35'

    server_1.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '256']
    end

    server_1.vm.provision 'shell', inline: $install_consul_script
    server_1.vm.provision 'shell', inline: $install_vault_script

    server_1.vm.provision(
      'shell',
      inline: "docker run -d --net=host consul:#{CONSUL_VERSION} agent" \
      ' -server -bind=192.168.33.35 -node=server-one -bootstrap-expect 5 -ui' \
      ' -datacenter dc1'
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
      inline: "docker run -d --net=host consul:#{CONSUL_VERSION} agent" \
      ' -server -bind=192.168.33.36 -join 192.168.33.35 -node=server-two -ui' \
      ' -datacenter dc1'
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
      inline: "docker run -d --net=host consul:#{CONSUL_VERSION} agent" \
      ' -server -bind=192.168.33.37 -join 192.168.33.36 -node=server-three -ui' \
      ' -datacenter dc1'
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
      inline: "docker run -d --net=host consul:#{CONSUL_VERSION} agent" \
      ' -server -bind=192.168.33.38 -join 192.168.33.37 -node=server-four -ui' \
      ' -datacenter dc1'
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
      inline: "docker run -d --net=host consul:#{CONSUL_VERSION} agent" \
      ' -server -bind=192.168.33.39 -join 192.168.33.38 -node=server-five -ui' \
      ' -datacenter dc1'
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
      inline: "docker run -d --net=host consul:#{CONSUL_VERSION} agent" \
      ' -bind=192.168.33.40 -join 192.168.33.35 -node=agent-one' \
      ' -datacenter dc1'
    )
  end
end
