#
# AWS VPC: https://www.terraform.io/docs/providers/aws/r/vpc.html
#
resource "aws_vpc" "main" {
  cidr_block = "${var.aws_vpc_cidr_block}"
  tags {
    "Name" = "${var.common_name}-${terraform.env}"
    "Terraform" = "true"
    "Environment" = "${terraform.env}"
  }
}
#
# AWS Internet Gateway
# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
# Gives subnets access to the outside world
#
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    "Name" = "${var.common_name}-${terraform.env}"
    "Terraform" = "true"
    "Environment" = "${terraform.env}"
  }
}
#
# AWS Route
# Grant the VPC internet access on the main route table
#
resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.default.id}"
}
#
# AWS Subnets to launch instances into
# https://www.terraform.io/docs/providers/aws/r/subnet.html
#
resource "aws_subnet" "public" {
  count = "${length(var.aws_vpc_cidr_public_subnets)}"
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.aws_vpc_cidr_public_subnets[count.index]}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  tags {
    "Name" = "${var.common_name}-${terraform.env}-${count.index}"
    "Terraform" = "true"
    "Environment" = "${terraform.env}"
  }
}
#
# AWS Load Balancing to front our instances
# https://www.terraform.io/docs/providers/aws/r/elb.html
#
resource "aws_elb" "elb" {
  name = "${var.common_name}-${terraform.env}"
  subnets = ["${aws_subnet.public.*.id}"]
  security_groups = ["${module.elb_http_security_group.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2 # be quick!
    unhealthy_threshold = 3
    timeout             = 10
    target              = "HTTP:80/"
    interval            = 15
  }
  tags {
    "Terraform" = "true"
    "Environment" = "${terraform.env}"
  }
}
#
# AWS Firewalls
#
# Example using a module
# https://github.com/ckelner/tf_aws_http_sg
#
module "elb_http_security_group" {
  source      = "github.com/ckelner/tf_aws_http_sg"
  vpc_id      = "${aws_vpc.main.id}"
  name_prefix = "${var.common_name}-${terraform.env}"
  description = "For allowing HTTP Traffic to the ELB"
  tags        = {
    "Terraform" = "true"
    "Environment" = "${terraform.env}"
  }
}
#
# Security Group not using a module
# https://www.terraform.io/docs/providers/aws/r/security_group.html
#
resource "aws_security_group" "web_sg" {
  name_prefix = "${var.common_name}-${terraform.env}"
  description = "Security Group from web node SSH"
  vpc_id      = "${aws_vpc.main.id}"
  tags        = {
    "Terraform" = "true"
    "Environment" = "${terraform.env}"
  }
}
#
# Security Group Rules
# https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
#
resource "aws_security_group_rule" "inbound_ssh_from_anywhere" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.web_sg.id}"
}
resource "aws_security_group_rule" "inbound_http_from_elb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${module.elb_http_security_group.id}"
  # silly hack for demo -- removed for the above after fixing the port issue
  # kept here for posterity for those that attended the demo
  # cidr_blocks     = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.web_sg.id}"
}
resource "aws_security_group_rule" "outbound_to_anywhere" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.web_sg.id}"
}
