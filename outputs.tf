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
output "instance_id" {
    value = "${aws_instance.web.id}"
}
output "instance_ip" {
    value = "${aws_instance.web.public_ip}"
}
