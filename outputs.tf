#############################################################################
# Outputs
# https://www.terraform.io/docs/configuration/outputs.html
#############################################################################
output "vpc_id" {
    value = "${aws_vpc.main.id}"
}
output "subnet_ids" {
    value = ["${aws_subnet.public.*.id}"]
}
output "elb_id" {
    value = "${aws_elb.elb.id}"
}
output "elb_dns_name " {
    value = "${aws_elb.elb.dns_name}"
}
output "elb_instance_ids" {
    value = "${aws_elb.elb.instances}"
}
output "asg_id" {
    value = "${aws_autoscaling_group.web_asg.id}"
}
