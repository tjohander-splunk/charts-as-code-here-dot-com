resource "signalfx_text_chart" "title0" {
  name     = " "
  markdown = <<-EOF
    <table width="100%" rules="none">
       <tbody>
          <tr>
             <td align="left" bgcolor="#7200ca" height="80px">
                <font size="5" color="#ffffff">Jumbotron</font>
             </td>
          </tr>
          <tr>
             <td align="left" bgcolor="#aa00ff" height="40px">
                <font size="3" color="#ffffff">Here is some demo data and couple panels to get you started.</font>
                <font size="3" color="#ffffff">An in-depth reference to the Terraform provider and resource definitions can be found <a href="https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs">here.</a></font>
             </td>
          </tr>
       </tbody>
    </table>
  EOF
}

#TODO: Add in Markdown text charts on top of each of these for a little blurb (mailto: tel:, etc)
#TODO Event feed on Dashboard
resource "signalfx_time_chart" "latencybydatacenter0" {
  name         = "Latency By Datacenter"
  description  = "Average Request Latency By Datacenter"
  plot_type    = "LineChart"
  program_text = <<-EOF
    A = data('demo.trans.latency', filter=filter('demo_datacenter', 'Tokyo'), rollup='average').mean(by=['demo_datacenter']).publish(label='A')
    B = data('demo.trans.latency', filter=filter('demo_datacenter', 'Paris')).mean(by=['demo_datacenter']).publish(label='B')
  EOF

  axis_left {
    label = "Request Latency"
    high_watermark = 230
    high_watermark_label = "Service Level Agreement"
  }

  viz_options {
    label  = "A"
    color  = "blue"
    value_unit = "Millisecond"
    value_suffix = " MS"
  }

  viz_options {
    label = "B"
    color = "green"
    value_unit = "Millisecond"
    value_suffix = " MS"
  }
}

resource "signalfx_time_chart" "hostsbydatacenter0" {
  name         = "Hosts By Datacenter"
  description  = "A count of hosts seen by the load balancer by datacenter"
  plot_type    = "LineChart"
  program_text = <<-EOF
    E = data('demo.lb.hosts', filter=filter('demo_datacenter', 'Tokyo'), rollup='sum').publish(label='Tokyo')
    F = data('demo.lb.hosts', filter=filter('demo_datacenter', 'Paris'), rollup='sum').publish(label='Paris')
  EOF


  axis_left {
    label = "Hosts"
  }

  viz_options {
    label = "Tokyo"
    color = "orange"
    value_suffix = " Hosts"
  }

  viz_options {
    label = "Paris"
    color = "purple"
    value_suffix = " Hosts"
  }

  legend_options_fields {
    property = "demo_datacenter"
    enabled  = true
  }

  on_chart_legend_dimension = "demo_datacenter"
}

resource "signalfx_dashboard" "dashboard0" {
  name            = "My Team Dashboad"
  dashboard_group = signalfx_dashboard_group.dashboardgroup0.id
  time_range      = "-1h"

  chart {
    chart_id = signalfx_text_chart.title0.id
    width    = 12
    height   = 1
    row      = 1
    column   = 0
  }

  chart {
    chart_id = signalfx_time_chart.latencybydatacenter0.id
    width    = 6
    height   = 1
    row      = 2
    column   = 0
  }

  chart {
    chart_id = signalfx_time_chart.hostsbydatacenter0.id
    width    = 6
    height   = 1
    row      = 2
    column   = 6
  }

}