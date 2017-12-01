# Output
Example of terraform output

# Environment select
```
$ terraform env select default
Switched to environment "default"!
```

# Plan
```
$ terraform plan -out=plan.out -var-file=dev.tfvars
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.aws_availability_zones.available: Refreshing state...
The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed. Cyan entries are data sources to be read.

Your plan was also saved to the path below. Call the "apply" subcommand
with this plan file and Terraform will exactly execute this execution
plan.

Path: plan.out

+ aws_autoscaling_group.web_asg
    arn:                               "<computed>"
    availability_zones.#:              "<computed>"
    default_cooldown:                  "<computed>"
    desired_capacity:                  "1"
    force_delete:                      "true"
    health_check_grace_period:         "300"
    health_check_type:                 "<computed>"
    launch_configuration:              "${aws_launch_configuration.web_lc.name}"
    load_balancers.#:                  "1"
    load_balancers.3003123756:         "datadog-demo-default"
    max_size:                          "2"
    metrics_granularity:               "1Minute"
    min_elb_capacity:                  "1"
    min_size:                          "1"
    name:                              "datadog-demo-default"
    protect_from_scale_in:             "false"
    tag.#:                             "1"
    tag.100011191.key:                 "Name"
    tag.100011191.propagate_at_launch: "true"
    tag.100011191.value:               "datadog-demo-default"
    target_group_arns.#:               "<computed>"
    termination_policies.#:            "1"
    termination_policies.0:            "OldestLaunchConfiguration"
    vpc_zone_identifier.#:             "<computed>"
    wait_for_capacity_timeout:         "5m"

+ aws_elb.elb
    availability_zones.#:                   "<computed>"
    connection_draining:                    "false"
    connection_draining_timeout:            "300"
    cross_zone_load_balancing:              "true"
    dns_name:                               "<computed>"
    health_check.#:                         "1"
    health_check.0.healthy_threshold:       "2"
    health_check.0.interval:                "30"
    health_check.0.target:                  "HTTP:8080/"
    health_check.0.timeout:                 "3"
    health_check.0.unhealthy_threshold:     "2"
    idle_timeout:                           "60"
    instances.#:                            "<computed>"
    internal:                               "<computed>"
    listener.#:                             "1"
    listener.3931999347.instance_port:      "8080"
    listener.3931999347.instance_protocol:  "http"
    listener.3931999347.lb_port:            "80"
    listener.3931999347.lb_protocol:        "http"
    listener.3931999347.ssl_certificate_id: ""
    name:                                   "datadog-demo-default"
    security_groups.#:                      "<computed>"
    source_security_group:                  "<computed>"
    source_security_group_id:               "<computed>"
    subnets.#:                              "<computed>"
    tags.%:                                 "2"
    tags.Environment:                       "default"
    tags.Terraform:                         "true"
    zone_id:                                "<computed>"

+ aws_internet_gateway.default
    tags.%:           "3"
    tags.Environment: "default"
    tags.Name:        "datadog-demo-default"
    tags.Terraform:   "true"
    vpc_id:           "${aws_vpc.main.id}"

+ aws_key_pair.aws_ssh_key
    fingerprint: "<computed>"
    key_name:    "datadog-demo-default"
    public_key:  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUT+RkR7kRcs7m/VnfbZFzNeVLNrHc1hunqfUJcqzh03j8C5G9D+sJM5Ks/9+0zQMspYbSvdz82KS1k5UTAYj/4asoOABV+UjUwOWHVDmyB4bPael583QLu62q31zhQXhHxueoB1bA6vPXa/bvvLfvV+p6M746I5nUuqEqZLJSNXopC/iF0gCjlTa2ovLudJSqTwZ9K+brHsqAiMWF1xEPa3lc2buHpfLQa/Jp6YFDVEPhuyj+Uqcx63D+hRtXXBgNalRfdG8MFRhtPJ+T4ME6cgr96zGtPzAHJA0DPAvwGWNaGKdQtb31+xkKAh0e4xAzV24+SqkQjluugVH5U9gJ Administrator@chriskelner-mbp"

+ aws_launch_configuration.web_lc
    associate_public_ip_address: "true"
    ebs_block_device.#:          "<computed>"
    ebs_optimized:               "<computed>"
    enable_monitoring:           "true"
    image_id:                    "ami-4191b524"
    instance_type:               "t2.nano"
    key_name:                    "datadog-demo-default"
    name:                        "<computed>"
    name_prefix:                 "datadog-demo-default"
    root_block_device.#:         "<computed>"
    security_groups.#:           "<computed>"
    user_data:                   "686fdda7fa2fa6636c165e69e100e815b5d77ac4"

+ aws_route.internet_access
    destination_cidr_block:     "0.0.0.0/0"
    destination_prefix_list_id: "<computed>"
    egress_only_gateway_id:     "<computed>"
    gateway_id:                 "${aws_internet_gateway.default.id}"
    instance_id:                "<computed>"
    instance_owner_id:          "<computed>"
    nat_gateway_id:             "<computed>"
    network_interface_id:       "<computed>"
    origin:                     "<computed>"
    route_table_id:             "${aws_vpc.main.main_route_table_id}"
    state:                      "<computed>"

+ aws_security_group.web_sg
    description:      "Security Group from web node SSH"
    egress.#:         "<computed>"
    ingress.#:        "<computed>"
    name:             "<computed>"
    name_prefix:      "datadog-demo-default"
    owner_id:         "<computed>"
    tags.%:           "2"
    tags.Environment: "default"
    tags.Terraform:   "true"
    vpc_id:           "${aws_vpc.main.id}"

+ aws_security_group_rule.http_to_anywhere
    from_port:                "8080"
    protocol:                 "tcp"
    security_group_id:        "${aws_security_group.web_sg.id}"
    self:                     "false"
    source_security_group_id: "${module.elb_http_security_group.id}"
    to_port:                  "8080"
    type:                     "egress"

+ aws_security_group_rule.inbound_ssh_from_anywhere
    cidr_blocks.#:            "1"
    cidr_blocks.0:            "0.0.0.0/0"
    from_port:                "22"
    protocol:                 "tcp"
    security_group_id:        "${aws_security_group.web_sg.id}"
    self:                     "false"
    source_security_group_id: "<computed>"
    to_port:                  "22"
    type:                     "ingress"

+ aws_subnet.public.0
    assign_ipv6_address_on_creation: "false"
    availability_zone:               "us-east-2a"
    cidr_block:                      "10.0.1.0/24"
    ipv6_cidr_block_association_id:  "<computed>"
    map_public_ip_on_launch:         "true"
    tags.%:                          "3"
    tags.Environment:                "default"
    tags.Name:                       "datadog-demo-default-0"
    tags.Terraform:                  "true"
    vpc_id:                          "${aws_vpc.main.id}"

+ aws_subnet.public.1
    assign_ipv6_address_on_creation: "false"
    availability_zone:               "us-east-2b"
    cidr_block:                      "10.0.2.0/24"
    ipv6_cidr_block_association_id:  "<computed>"
    map_public_ip_on_launch:         "true"
    tags.%:                          "3"
    tags.Environment:                "default"
    tags.Name:                       "datadog-demo-default-1"
    tags.Terraform:                  "true"
    vpc_id:                          "${aws_vpc.main.id}"

+ aws_subnet.public.2
    assign_ipv6_address_on_creation: "false"
    availability_zone:               "us-east-2c"
    cidr_block:                      "10.0.3.0/24"
    ipv6_cidr_block_association_id:  "<computed>"
    map_public_ip_on_launch:         "true"
    tags.%:                          "3"
    tags.Environment:                "default"
    tags.Name:                       "datadog-demo-default-2"
    tags.Terraform:                  "true"
    vpc_id:                          "${aws_vpc.main.id}"

+ aws_vpc.main
    assign_generated_ipv6_cidr_block: "false"
    cidr_block:                       "10.0.0.0/16"
    default_network_acl_id:           "<computed>"
    default_route_table_id:           "<computed>"
    default_security_group_id:        "<computed>"
    dhcp_options_id:                  "<computed>"
    enable_classiclink:               "<computed>"
    enable_dns_hostnames:             "<computed>"
    enable_dns_support:               "true"
    instance_tenancy:                 "<computed>"
    ipv6_association_id:              "<computed>"
    ipv6_cidr_block:                  "<computed>"
    main_route_table_id:              "<computed>"
    tags.%:                           "3"
    tags.Environment:                 "default"
    tags.Name:                        "datadog-demo-default"
    tags.Terraform:                   "true"

+ module.elb_http_security_group.aws_security_group.sg
    description:      "For allowing HTTP Traffic to the ELB"
    egress.#:         "<computed>"
    ingress.#:        "<computed>"
    name:             "<computed>"
    name_prefix:      "datadog-demo-default"
    owner_id:         "<computed>"
    tags.%:           "2"
    tags.Environment: "default"
    tags.Terraform:   "true"
    vpc_id:           "${var.vpc_id}"

+ module.elb_http_security_group.aws_security_group_rule.inbound_http_from_anywhere
    cidr_blocks.#:            "1"
    cidr_blocks.0:            "0.0.0.0/0"
    from_port:                "80"
    protocol:                 "tcp"
    security_group_id:        "${aws_security_group.sg.id}"
    self:                     "false"
    source_security_group_id: "<computed>"
    to_port:                  "80"
    type:                     "ingress"

+ module.elb_http_security_group.aws_security_group_rule.outbound_internet_to_anywhere
    cidr_blocks.#:            "1"
    cidr_blocks.0:            "0.0.0.0/0"
    from_port:                "0"
    protocol:                 "-1"
    security_group_id:        "${aws_security_group.sg.id}"
    self:                     "false"
    source_security_group_id: "<computed>"
    to_port:                  "0"
    type:                     "egress"


Plan: 16 to add, 0 to change, 0 to destroy.
```

# Apply
```
$ terraform apply plan.out
aws_vpc.main: Creating...
  assign_generated_ipv6_cidr_block: "" => "false"
  cidr_block:                       "" => "10.0.0.0/16"
  default_network_acl_id:           "" => "<computed>"
  default_route_table_id:           "" => "<computed>"
  default_security_group_id:        "" => "<computed>"
  dhcp_options_id:                  "" => "<computed>"
  enable_classiclink:               "" => "<computed>"
  enable_dns_hostnames:             "" => "<computed>"
  enable_dns_support:               "" => "true"
  instance_tenancy:                 "" => "<computed>"
  ipv6_association_id:              "" => "<computed>"
  ipv6_cidr_block:                  "" => "<computed>"
  main_route_table_id:              "" => "<computed>"
  tags.%:                           "" => "3"
  tags.Environment:                 "" => "default"
  tags.Name:                        "" => "datadog-demo-default"
  tags.Terraform:                   "" => "true"
aws_key_pair.aws_ssh_key: Creating...
  fingerprint: "" => "<computed>"
  key_name:    "" => "datadog-demo-default"
  public_key:  "" => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUT+RkR7kRcs7m/VnfbZFzNeVLNrHc1hunqfUJcqzh03j8C5G9D+sJM5Ks/9+0zQMspYbSvdz82KS1k5UTAYj/4asoOABV+UjUwOWHVDmyB4bPael583QLu62q31zhQXhHxueoB1bA6vPXa/bvvLfvV+p6M746I5nUuqEqZLJSNXopC/iF0gCjlTa2ovLudJSqTwZ9K+brHsqAiMWF1xEPa3lc2buHpfLQa/Jp6YFDVEPhuyj+Uqcx63D+hRtXXBgNalRfdG8MFRhtPJ+T4ME6cgr96zGtPzAHJA0DPAvwGWNaGKdQtb31+xkKAh0e4xAzV24+SqkQjluugVH5U9gJ Administrator@chriskelner-mbp"
aws_key_pair.aws_ssh_key: Creation complete (ID: datadog-demo-default)
aws_vpc.main: Creation complete (ID: vpc-a3d2b2ca)
aws_internet_gateway.default: Creating...
  tags.%:           "0" => "3"
  tags.Environment: "" => "default"
  tags.Name:        "" => "datadog-demo-default"
  tags.Terraform:   "" => "true"
  vpc_id:           "" => "vpc-a3d2b2ca"
aws_security_group.web_sg: Creating...
  description:      "" => "Security Group from web node SSH"
  egress.#:         "" => "<computed>"
  ingress.#:        "" => "<computed>"
  name:             "" => "<computed>"
  name_prefix:      "" => "datadog-demo-default"
  owner_id:         "" => "<computed>"
  tags.%:           "" => "2"
  tags.Environment: "" => "default"
  tags.Terraform:   "" => "true"
  vpc_id:           "" => "vpc-a3d2b2ca"
aws_subnet.public.1: Creating...
  assign_ipv6_address_on_creation: "" => "false"
  availability_zone:               "" => "us-east-2b"
  cidr_block:                      "" => "10.0.2.0/24"
  ipv6_cidr_block_association_id:  "" => "<computed>"
  map_public_ip_on_launch:         "" => "true"
  tags.%:                          "" => "3"
  tags.Environment:                "" => "default"
  tags.Name:                       "" => "datadog-demo-default-1"
  tags.Terraform:                  "" => "true"
  vpc_id:                          "" => "vpc-a3d2b2ca"
aws_subnet.public.0: Creating...
  assign_ipv6_address_on_creation: "" => "false"
  availability_zone:               "" => "us-east-2a"
  cidr_block:                      "" => "10.0.1.0/24"
  ipv6_cidr_block_association_id:  "" => "<computed>"
  map_public_ip_on_launch:         "" => "true"
  tags.%:                          "" => "3"
  tags.Environment:                "" => "default"
  tags.Name:                       "" => "datadog-demo-default-0"
  tags.Terraform:                  "" => "true"
  vpc_id:                          "" => "vpc-a3d2b2ca"
aws_subnet.public.2: Creating...
  assign_ipv6_address_on_creation: "" => "false"
  availability_zone:               "" => "us-east-2c"
  cidr_block:                      "" => "10.0.3.0/24"
  ipv6_cidr_block_association_id:  "" => "<computed>"
  map_public_ip_on_launch:         "" => "true"
  tags.%:                          "" => "3"
  tags.Environment:                "" => "default"
  tags.Name:                       "" => "datadog-demo-default-2"
  tags.Terraform:                  "" => "true"
  vpc_id:                          "" => "vpc-a3d2b2ca"
module.elb_http_security_group.aws_security_group.sg: Creating...
  description:      "" => "For allowing HTTP Traffic to the ELB"
  egress.#:         "" => "<computed>"
  ingress.#:        "" => "<computed>"
  name:             "" => "<computed>"
  name_prefix:      "" => "datadog-demo-default"
  owner_id:         "" => "<computed>"
  tags.%:           "" => "2"
  tags.Environment: "" => "default"
  tags.Terraform:   "" => "true"
  vpc_id:           "" => "vpc-a3d2b2ca"
aws_internet_gateway.default: Creation complete (ID: igw-795cd910)
aws_route.internet_access: Creating...
  destination_cidr_block:     "" => "0.0.0.0/0"
  destination_prefix_list_id: "" => "<computed>"
  egress_only_gateway_id:     "" => "<computed>"
  gateway_id:                 "" => "igw-795cd910"
  instance_id:                "" => "<computed>"
  instance_owner_id:          "" => "<computed>"
  nat_gateway_id:             "" => "<computed>"
  network_interface_id:       "" => "<computed>"
  origin:                     "" => "<computed>"
  route_table_id:             "" => "rtb-903a4af9"
  state:                      "" => "<computed>"
aws_subnet.public.2: Creation complete (ID: subnet-9c70bcd1)
aws_subnet.public.0: Creation complete (ID: subnet-5187f138)
module.elb_http_security_group.aws_security_group.sg: Creation complete (ID: sg-cb94a3a2)
module.elb_http_security_group.aws_security_group_rule.inbound_http_from_anywhere: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "80"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-cb94a3a2"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "80"
  type:                     "" => "ingress"
module.elb_http_security_group.aws_security_group_rule.outbound_internet_to_anywhere: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "0"
  protocol:                 "" => "-1"
  security_group_id:        "" => "sg-cb94a3a2"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "0"
  type:                     "" => "egress"
aws_subnet.public.1: Creation complete (ID: subnet-7cd86707)
aws_elb.elb: Creating...
  availability_zones.#:                   "" => "<computed>"
  connection_draining:                    "" => "false"
  connection_draining_timeout:            "" => "300"
  cross_zone_load_balancing:              "" => "true"
  dns_name:                               "" => "<computed>"
  health_check.#:                         "" => "1"
  health_check.0.healthy_threshold:       "" => "2"
  health_check.0.interval:                "" => "15"
  health_check.0.target:                  "" => "HTTP:80/"
  health_check.0.timeout:                 "" => "10"
  health_check.0.unhealthy_threshold:     "" => "3"
  idle_timeout:                           "" => "60"
  instances.#:                            "" => "<computed>"
  internal:                               "" => "<computed>"
  listener.#:                             "" => "1"
  listener.3057123346.instance_port:      "" => "80"
  listener.3057123346.instance_protocol:  "" => "http"
  listener.3057123346.lb_port:            "" => "80"
  listener.3057123346.lb_protocol:        "" => "http"
  listener.3057123346.ssl_certificate_id: "" => ""
  name:                                   "" => "datadog-demo-default"
  security_groups.#:                      "" => "1"
  security_groups.1759350173:             "" => "sg-cb94a3a2"
  source_security_group:                  "" => "<computed>"
  source_security_group_id:               "" => "<computed>"
  subnets.#:                              "" => "3"
  subnets.143700470:                      "" => "subnet-7cd86707"
  subnets.1945185290:                     "" => "subnet-5187f138"
  subnets.3206459808:                     "" => "subnet-9c70bcd1"
  tags.%:                                 "" => "2"
  tags.Environment:                       "" => "default"
  tags.Terraform:                         "" => "true"
  zone_id:                                "" => "<computed>"
aws_route.internet_access: Creation complete (ID: r-rtb-903a4af91080289494)
aws_security_group.web_sg: Creation complete (ID: sg-1295a27b)
aws_security_group_rule.outbound_to_anywhere: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "0"
  protocol:                 "" => "-1"
  security_group_id:        "" => "sg-1295a27b"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "0"
  type:                     "" => "egress"
aws_security_group_rule.inbound_http_from_elb: Creating...
  from_port:                "" => "80"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-1295a27b"
  self:                     "" => "false"
  source_security_group_id: "" => "sg-cb94a3a2"
  to_port:                  "" => "80"
  type:                     "" => "ingress"
aws_security_group_rule.inbound_ssh_from_anywhere: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "22"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-1295a27b"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "22"
  type:                     "" => "ingress"
aws_launch_configuration.web_lc: Creating...
  associate_public_ip_address: "" => "true"
  ebs_block_device.#:          "" => "<computed>"
  ebs_optimized:               "" => "<computed>"
  enable_monitoring:           "" => "true"
  image_id:                    "" => "ami-4191b524"
  instance_type:               "" => "t2.nano"
  key_name:                    "" => "datadog-demo-default"
  name:                        "" => "<computed>"
  name_prefix:                 "" => "datadog-demo-default"
  root_block_device.#:         "" => "<computed>"
  security_groups.#:           "" => "1"
  security_groups.3877861424:  "" => "sg-1295a27b"
  user_data:                   "" => "e6b3b9e97e683479b28f91a28c4c81857e423447"
module.elb_http_security_group.aws_security_group_rule.inbound_http_from_anywhere: Creation complete (ID: sgrule-3799191295)
aws_security_group_rule.inbound_http_from_elb: Creation complete (ID: sgrule-1279756416)
aws_launch_configuration.web_lc: Creation complete (ID: datadog-demo-default00a2e5795f6d7ca81fee44f63c)
module.elb_http_security_group.aws_security_group_rule.outbound_internet_to_anywhere: Creation complete (ID: sgrule-1990669991)
aws_security_group_rule.outbound_to_anywhere: Creation complete (ID: sgrule-3657623197)
aws_security_group_rule.inbound_ssh_from_anywhere: Creation complete (ID: sgrule-389148016)
aws_elb.elb: Creation complete (ID: datadog-demo-default)
aws_autoscaling_group.web_asg: Creating...
  arn:                               "" => "<computed>"
  availability_zones.#:              "" => "<computed>"
  default_cooldown:                  "" => "<computed>"
  desired_capacity:                  "" => "1"
  force_delete:                      "" => "true"
  health_check_grace_period:         "" => "300"
  health_check_type:                 "" => "<computed>"
  launch_configuration:              "" => "datadog-demo-default00a2e5795f6d7ca81fee44f63c"
  load_balancers.#:                  "" => "1"
  load_balancers.3003123756:         "" => "datadog-demo-default"
  max_size:                          "" => "2"
  metrics_granularity:               "" => "1Minute"
  min_elb_capacity:                  "" => "1"
  min_size:                          "" => "1"
  name:                              "" => "datadog-demo-default"
  protect_from_scale_in:             "" => "false"
  tag.#:                             "" => "1"
  tag.100011191.key:                 "" => "Name"
  tag.100011191.propagate_at_launch: "" => "true"
  tag.100011191.value:               "" => "datadog-demo-default"
  target_group_arns.#:               "" => "<computed>"
  termination_policies.#:            "" => "1"
  termination_policies.0:            "" => "OldestLaunchConfiguration"
  vpc_zone_identifier.#:             "" => "3"
  vpc_zone_identifier.143700470:     "" => "subnet-7cd86707"
  vpc_zone_identifier.1945185290:    "" => "subnet-5187f138"
  vpc_zone_identifier.3206459808:    "" => "subnet-9c70bcd1"
  wait_for_capacity_timeout:         "" => "10m"
aws_autoscaling_group.web_asg: Still creating... (10s elapsed)
aws_autoscaling_group.web_asg: Still creating... (20s elapsed)
aws_autoscaling_group.web_asg: Still creating... (30s elapsed)
aws_autoscaling_group.web_asg: Still creating... (40s elapsed)
aws_autoscaling_group.web_asg: Still creating... (50s elapsed)
aws_autoscaling_group.web_asg: Still creating... (1m0s elapsed)
aws_autoscaling_group.web_asg: Still creating... (1m10s elapsed)
aws_autoscaling_group.web_asg: Still creating... (1m20s elapsed)
aws_autoscaling_group.web_asg: Still creating... (1m30s elapsed)
aws_autoscaling_group.web_asg: Creation complete (ID: datadog-demo-default)

Apply complete! Resources: 17 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path:

Outputs:

asg_id = datadog-demo-default
elb_dns_name  = datadog-demo-default-1355155384.us-east-2.elb.amazonaws.com
elb_id = datadog-demo-default
elb_instance_ids = []
subnet_ids = [
    subnet-5187f138,
    subnet-7cd86707,
    subnet-9c70bcd1
]
vpc_id = vpc-a3d2b2ca
```

# Plan to Destroy
```
$ terraform plan -destroy -out=plan.out -var-file=dev.tfvars
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_key_pair.aws_ssh_key: Refreshing state... (ID: datadog-demo-default)
aws_vpc.main: Refreshing state... (ID: vpc-889afae1)
data.aws_availability_zones.available: Refreshing state...
aws_subnet.public.0: Refreshing state... (ID: subnet-2540364c)
aws_security_group.web_sg: Refreshing state... (ID: sg-72f0c71b)
aws_internet_gateway.default: Refreshing state... (ID: igw-13b1347a)
aws_subnet.public.2: Refreshing state... (ID: subnet-ae5894e3)
aws_subnet.public.1: Refreshing state... (ID: subnet-9d0db1e6)
aws_security_group.sg: Refreshing state... (ID: sg-7efbcc17)
aws_security_group_rule.outbound_internet_to_anywhere: Refreshing state... (ID: sgrule-4002393656)
aws_security_group_rule.inbound_http_from_anywhere: Refreshing state... (ID: sgrule-3263003507)
aws_security_group_rule.outbound_to_anywhere: Refreshing state... (ID: sgrule-4293212510)
aws_security_group_rule.inbound_ssh_from_anywhere: Refreshing state... (ID: sgrule-3170063686)
aws_security_group_rule.inbound_http_from_elb: Refreshing state... (ID: sgrule-2320856339)
aws_launch_configuration.web_lc: Refreshing state... (ID: datadog-demo-default00ebf00c3b04d2ff963cf68a87)
aws_route.internet_access: Refreshing state... (ID: r-rtb-01fc8d681080289494)
aws_elb.elb: Refreshing state... (ID: datadog-demo-default)
aws_autoscaling_group.web_asg: Refreshing state... (ID: datadog-demo-default)
The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed. Cyan entries are data sources to be read.

Your plan was also saved to the path below. Call the "apply" subcommand
with this plan file and Terraform will exactly execute this execution
plan.

Path: plan.out

- aws_autoscaling_group.web_asg

- aws_elb.elb

- aws_internet_gateway.default

- aws_key_pair.aws_ssh_key

- aws_launch_configuration.web_lc

- aws_route.internet_access

- aws_security_group.web_sg

- aws_security_group_rule.inbound_ssh_from_anywhere

- aws_security_group_rule.outbound_to_anywhere

- aws_subnet.public.0

- aws_subnet.public.1

- aws_subnet.public.2

- aws_vpc.main

- data.aws_availability_zones.available

- module.elb_http_security_group.aws_security_group.sg

- module.elb_http_security_group.aws_security_group_rule.inbound_http_from_anywhere

- module.elb_http_security_group.aws_security_group_rule.outbound_internet_to_anywhere


Plan: 0 to add, 0 to change, 16 to destroy.
```

# Apply a planned destroy
```
$ terraform destroy -var-file=dev.tfvars
Do you really want to destroy?
  Terraform will delete all your managed infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_key_pair.aws_ssh_key: Refreshing state... (ID: datadog-demo-default)
aws_vpc.main: Refreshing state... (ID: vpc-46b1d12f)
data.aws_availability_zones.available: Refreshing state...
aws_subnet.public.1: Refreshing state... (ID: subnet-3e338f45)
aws_security_group.web_sg: Refreshing state... (ID: sg-8f3304e6)
aws_subnet.public.0: Refreshing state... (ID: subnet-0e790f67)
aws_internet_gateway.default: Refreshing state... (ID: igw-9a9c19f3)
aws_subnet.public.2: Refreshing state... (ID: subnet-3439f579)
aws_security_group.sg: Refreshing state... (ID: sg-3d3e0954)
aws_security_group_rule.inbound_http_from_anywhere: Refreshing state... (ID: sgrule-3044442922)
aws_security_group_rule.outbound_internet_to_anywhere: Refreshing state... (ID: sgrule-788482488)
aws_elb.elb: Refreshing state... (ID: datadog-demo-default)
aws_security_group_rule.inbound_ssh_from_anywhere: Refreshing state... (ID: sgrule-3861586535)
aws_security_group_rule.http_to_anywhere: Refreshing state... (ID: sgrule-3762255889)
aws_launch_configuration.web_lc: Refreshing state... (ID: datadog-demo-default00a96229f752d548edb3899332)
aws_route.internet_access: Refreshing state... (ID: r-rtb-acabdac51080289494)
aws_autoscaling_group.web_asg: Refreshing state... (ID: datadog-demo-default)
aws_autoscaling_group.web_asg: Destroying... (ID: datadog-demo-default)
aws_security_group_rule.http_to_anywhere: Destroying... (ID: sgrule-3762255889)
aws_security_group_rule.inbound_ssh_from_anywhere: Destroying... (ID: sgrule-3861586535)
aws_route.internet_access: Destroying... (ID: r-rtb-acabdac51080289494)
aws_route.internet_access: Destruction complete
aws_internet_gateway.default: Destroying... (ID: igw-9a9c19f3)
aws_security_group_rule.inbound_ssh_from_anywhere: Destruction complete
module.elb_http_security_group.aws_security_group_rule.inbound_http_from_anywhere: Destroying... (ID: sgrule-3044442922)
module.elb_http_security_group.aws_security_group_rule.outbound_internet_to_anywhere: Destroying... (ID: sgrule-788482488)
aws_security_group_rule.http_to_anywhere: Destruction complete
module.elb_http_security_group.aws_security_group_rule.outbound_internet_to_anywhere: Destruction complete
module.elb_http_security_group.aws_security_group_rule.inbound_http_from_anywhere: Destruction complete
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 10s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 10s elapsed)
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 20s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 20s elapsed)
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 30s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 30s elapsed)
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 40s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 40s elapsed)
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 50s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 50s elapsed)
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 1m0s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 1m0s elapsed)
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 1m10s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 1m10s elapsed)
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 1m20s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 1m20s elapsed)
aws_autoscaling_group.web_asg: Still destroying... (ID: datadog-demo-default, 1m30s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 1m30s elapsed)
aws_autoscaling_group.web_asg: Destruction complete
aws_launch_configuration.web_lc: Destroying... (ID: datadog-demo-default00a96229f752d548edb3899332)
aws_elb.elb: Destroying... (ID: datadog-demo-default)
aws_elb.elb: Destruction complete
module.elb_http_security_group.aws_security_group.sg: Destroying... (ID: sg-3d3e0954)
aws_subnet.public.1: Destroying... (ID: subnet-3e338f45)
aws_subnet.public.0: Destroying... (ID: subnet-0e790f67)
aws_subnet.public.2: Destroying... (ID: subnet-3439f579)
aws_launch_configuration.web_lc: Destruction complete
aws_security_group.web_sg: Destroying... (ID: sg-8f3304e6)
aws_key_pair.aws_ssh_key: Destroying... (ID: datadog-demo-default)
aws_key_pair.aws_ssh_key: Destruction complete
aws_subnet.public.1: Destruction complete
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 1m40s elapsed)
aws_security_group.web_sg: Destruction complete
module.elb_http_security_group.aws_security_group.sg: Still destroying... (ID: sg-3d3e0954, 10s elapsed)
aws_subnet.public.2: Still destroying... (ID: subnet-3439f579, 10s elapsed)
aws_subnet.public.0: Still destroying... (ID: subnet-0e790f67, 10s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 1m50s elapsed)
module.elb_http_security_group.aws_security_group.sg: Still destroying... (ID: sg-3d3e0954, 20s elapsed)
aws_subnet.public.2: Still destroying... (ID: subnet-3439f579, 20s elapsed)
aws_subnet.public.0: Still destroying... (ID: subnet-0e790f67, 20s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 2m0s elapsed)
module.elb_http_security_group.aws_security_group.sg: Still destroying... (ID: sg-3d3e0954, 30s elapsed)
aws_subnet.public.0: Still destroying... (ID: subnet-0e790f67, 30s elapsed)
aws_subnet.public.2: Still destroying... (ID: subnet-3439f579, 30s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 2m10s elapsed)
module.elb_http_security_group.aws_security_group.sg: Still destroying... (ID: sg-3d3e0954, 40s elapsed)
aws_subnet.public.2: Still destroying... (ID: subnet-3439f579, 40s elapsed)
aws_subnet.public.0: Still destroying... (ID: subnet-0e790f67, 40s elapsed)
aws_internet_gateway.default: Still destroying... (ID: igw-9a9c19f3, 2m20s elapsed)
aws_subnet.public.2: Destruction complete
aws_subnet.public.0: Destruction complete
data.aws_availability_zones.available: Destroying... (ID: 2017-06-07 12:08:52.614485044 +0000 UTC)
data.aws_availability_zones.available: Destruction complete
aws_internet_gateway.default: Destruction complete
module.elb_http_security_group.aws_security_group.sg: Destruction complete
aws_vpc.main: Destroying... (ID: vpc-46b1d12f)
aws_vpc.main: Destruction complete

Destroy complete! Resources: 17 destroyed.
```
