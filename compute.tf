#
# AWS SSH Key Pair; Public key is placed on instances to enable SSH
# https://www.terraform.io/docs/providers/aws/r/key_pair.html
#
resource "aws_key_pair" "aws_ssh_key" {
  key_name   = "${var.common_name}-${terraform.env}"
  public_key = "${var.aws_public_key_material}"
}
#
# AWS EC2 Instance
# https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
#
resource "aws_instance" "web" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.aws_instance_type}"
  vpc_security_group_ids = [
    "${aws_security_group.web_sg.id}",
    "${module.http_security_group.id}"
  ]
  user_data = <<-EOF
    sudo yum install nginx -y
    sudo chkconfig nginx on
    sudo service nginx start
    sudo service iptables stop
    sudo chkconfig iptables off
    DD_API_KEY="${var.datadog_api_key}" bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)"
  EOF
  key_name = "${aws_key_pair.aws_ssh_key.key_name}"
  associate_public_ip_address = true
  tags {
    Name = "HelloWorld"
  }
}
