resource "signalfx_dashboard_group" "dashboardgroup0" {
  name        = "${var.sfx_prefix} Dashboard Group"
  description = "My Team's Dashboards"
}