#
# DD Provider: https://www.terraform.io/docs/providers/datadog/index.html
#
provider "datadog" {
  api_key = "${var.datadog_api_key}"
  app_key = "${var.datadog_app_key}"
}
#
# Datadog Monitor
# https://www.terraform.io/docs/providers/datadog/r/monitor.html
# Dummy data, for demo purposes only
#
resource "datadog_monitor" "foo" {
  name               = "Name for monitor foo"
  type               = "metric alert"
  message            = "Monitor triggered. Notify: @hipchat-channel"
  query = "avg(last_1h):avg:aws.ec2.cpu{environment:foo,host:foo} by {host} > 2"
  thresholds {
    ok       = 0
    warning  = 1
    critical = 2
  }
  timeout_h          = 60
  include_tags       = true
  silenced {
    "*" = 0
  }
  tags = ["foo:bar", "baz"]
}
