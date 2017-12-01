#############################################################################
# Variables
# https://www.terraform.io/docs/configuration/variables.html
#############################################################################
variable "aws_region" {
  description = "The region to provision AWS resources in."
}
variable "common_name" {
  description = "The common environment name to use for most resources."
  default = "datadog-demo"
}
variable "aws_vpc_cidr_block" {
  description = "The CIDR block to use for the AWS VPC."
  default = "10.0.0.0/16"
}
variable "aws_vpc_cidr_public_subnets" {
  description = "The public subnet CIDR blocks"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "aws_amis" {
  description = "AWS AMIs for Amazon Linux 2017.03.0 (HVM) with SSD Volume."
  default = {
    "us-east-2" = "ami-4191b524"
    "us-west-2" = "ami-4836a428"
  }
}
variable "aws_instance_type" {
  default = "t2.nano"
  description = "The AWS instance type to launch."
}
variable "aws_asg_min" {
  description = "Minimum number of servers in AWS ASG."
}
variable "aws_asg_max" {
  description = "Maximum numbers of servers in AWS ASG."
}
variable "aws_asg_desired" {
  description = "Desired numbers of servers in ASG"
}
variable "aws_public_key_material" {
  description = "The public SSH key material to load onto the instances."
}
