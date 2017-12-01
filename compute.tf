#
# AWS SSH Key Pair; Public key is placed on instances to enable SSH
# https://www.terraform.io/docs/providers/aws/r/key_pair.html
#
resource "aws_key_pair" "aws_ssh_key" {
  key_name   = "${var.common_name}-${terraform.env}"
  public_key = "${var.aws_public_key_material}"
}
#
# AWS Autoscaling Group
# https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
#
resource "aws_autoscaling_group" "web_asg" {
  name                      = "${var.common_name}-${terraform.env}"
  vpc_zone_identifier       = ["${aws_subnet.public.*.id}"]
  max_size                  = "${var.aws_asg_max}"
  min_size                  = "${var.aws_asg_min}"
  desired_capacity          = "${var.aws_asg_desired}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.web_lc.name}"
  load_balancers            = ["${aws_elb.elb.name}"]
  termination_policies      = ["OldestLaunchConfiguration"]
  # Kelnerhax: last min hack for demo was to switch this to "0"
  # due to some firewall issues that were present on my part --
  # we actually fixed this during the demo
  wait_for_capacity_timeout = "10m" # 5m isn't quite enough time
  min_elb_capacity          = "${var.aws_asg_min}"
  # you wouldn't normally use this because you'd want it to
  # drain, but for demo purposes it's useful to move quickly
  force_delete              = true
  tag = {
    key                     = "Name"
    value                   = "${var.common_name}-${terraform.env}"
    propagate_at_launch     = "true"
  }
  lifecycle {
    create_before_destroy   = true
  }
}
#
# AWS Launch Config
# https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
#
resource "aws_launch_configuration" "web_lc" {
  name_prefix                 = "${var.common_name}-${terraform.env}"
  image_id                    = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type               = "${var.aws_instance_type}"
  security_groups             = ["${aws_security_group.web_sg.id}"]
  user_data                   = "${file("userdata.sh")}"
  key_name                    = "${aws_key_pair.aws_ssh_key.key_name}"
  associate_public_ip_address = true
  # launch configs cannot be updated after they've been
  # created, so terraform will delete and create a new one
  # when there are updates. AWS will not allow an LC to be
  # deleted if it is part of an ASG and another doesn't yet
  # exist. This lifecycle rule tells terraform to create a
  # new LC first, then delete the old one.
  lifecycle {
    create_before_destroy     = true
  }
}
