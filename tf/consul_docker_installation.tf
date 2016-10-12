data "template_file" "user_data" {
  template = <<EOT
#!/bin/bash
yum install -y curl unzip wget bind-utils docker

service docker restart

docker run -d --restart=always --net=host -p 8301:8301 -p 8301:8301/udp -p 8400:8400 -p 8500:8500 -p 53:53/udp \
consul:$${consul_version} agent -server -bind=$$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4) \
-node=$$(curl -s http://169.254.169.254/latest/meta-data/instance-id) -ui -datacenter dc1 \
-bootstrap-expect 6 -join $${join_ip}

EOT

  vars {
    consul_version = "${var.consul_version}"
    join_ip        = "${lookup(var.instance_ips_subnet_0, 0)}"
  }
}
