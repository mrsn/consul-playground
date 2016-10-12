variable "aws_region" {
  default = "eu-central-1"
}

variable "instance_ips_subnet_0" {
  default = {
    "0" = "10.0.94.100"
    "1" = "10.0.94.101"
    "2" = "10.0.94.102"
  }
}

variable "instance_ips_subnet_1" {
  default = {
    "0" = "10.0.101.103"
    "1" = "10.0.101.104"
    "2" = "10.0.101.105"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "consul_version" {
  default = "v0.7.0"
}

variable "ami_id" {
  default = "ami-0044b96f"
}

variable "nodes_pro_az" {
  default = "3"
}

variable "subnet_id_a" {}

variable "subnet_id_b" {}

variable "key_name" {}

variable "additional_security_group" {}

variable "vpc_id" {}
