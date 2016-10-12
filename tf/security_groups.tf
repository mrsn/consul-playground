resource "aws_security_group" "consul" {
  name        = "consul_sg"
  description = "allow everything needed for consul"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "server_rpc" {
  type              = "ingress"
  from_port         = 8300
  to_port           = 8300
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "serf_lan_udp" {
  type              = "ingress"
  from_port         = 8301
  to_port           = 8301
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "serf_lan_tcp" {
  type              = "ingress"
  from_port         = 8301
  to_port           = 8301
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "serf_wan_udp" {
  type              = "ingress"
  from_port         = 8302
  to_port           = 8302
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "serf_wan_tcp" {
  type              = "ingress"
  from_port         = 8302
  to_port           = 8302
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "cli_rpc" {
  type              = "ingress"
  from_port         = 8400
  to_port           = 8400
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "http_api" {
  type              = "ingress"
  from_port         = 8500
  to_port           = 8500
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "dns_interface_tcp" {
  type              = "ingress"
  from_port         = 8600
  to_port           = 8600
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}

resource "aws_security_group_rule" "dns_interface_udp" {
  type              = "ingress"
  from_port         = 8600
  to_port           = 8600
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul.id}"
}
