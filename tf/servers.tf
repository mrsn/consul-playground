provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "consul_server_a" {
  count         = "${var.nodes_pro_az}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  tags {
    Name = "consul-cluster-node-A-${count.index}"
  }

  private_ip = "${lookup(var.instance_ips_subnet_0, count.index)}"

  # 10.0.96.0 / 19 -> 10.0.64.1 : 10.95.254
  subnet_id              = "${var.subnet_id_a}"
  user_data              = "${data.template_file.user_data.rendered}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.additional_security_group}", "${aws_security_group.consul.id}"]
}

resource "aws_instance" "consul_server_b" {
  count         = "${var.nodes_pro_az}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  tags {
    Name = "consul-cluster-node-B-${count.index}"
  }

  private_ip = "${lookup(var.instance_ips_subnet_1, count.index)}"

  # 10.0.64.0 / 19 -> 10.0.96.1 : 10.0.127.254
  subnet_id              = "${var.subnet_id_b}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.additional_security_group}", "${aws_security_group.consul.id}"]
  user_data              = "${data.template_file.user_data.rendered}"
}
