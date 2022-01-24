## Charts-As-Code With Splunk Observability and Terraform

This repo is a quick example of the possibilities of integrating Splunk Observability dashboards, charts and alerts with automation workflows using Terraform.

## Create all the Things
### Install Terraform (optional)
To try out the examples in here, it's easiest to install and run the Terraform binary locally. Instructions to get started are [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).  If you know what you're doing and have access to an on-premise or cloud deployment of Terraform, feel free to use that.

### Grab your `realm` and `access_token` for your instance of Observability Cloud.
* Your realm can be found in the URL that's used to connect to Observability.  It will likely be `us0` or `us1`.  In the example `https://app.us1.signalfx.com/#/home`, the realm is `us1`.
* Access tokens can be found in the Observability menu `Settings -> Access Tokens`.

### Set a prefix value to prepend to the resources you create in this example. (optional)
This provides a nice way to identify these sample resources you deploy into your environment

Once that's installed, you can run the example by executing locally:
```bash
terraform apply -var="access_token=<access token>" -var="realm=<your o11y realm>" -var="sfx_prefix=<resource name prefix>"
```

## Resources
This repo should be enough to get started with some basics. To learn more about the provider and underlying API for Observability Cloud, here are some good jumping off points.

### Terraform Provider Documentation
The documentation for the Terraform Provider is [here](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs). Resource definitions are found my expanding the "Resources" link in the left-side nav menu.

### Splunk Observability API Reference
The Terraform provider relies on Observability Cloud's public APIs. The Terraform provider does all the heavy lifting for you, but it can be helpful to refer to the underlying REST APIs that are invoked by the provider. Here are some useful links: 

The reference documentation portal is [here](https://dev.splunk.com/observability/reference)

Specific sections of interest to the resources here are:
* [Detectors](https://api.{REALM}.signalfx.com/v2/detector)
* [Charts](https://dev.splunk.com/observability/reference/api/charts/latest#endpoint-create-single-chart)
* [Notifications](https://dev.splunk.com/observability/reference/api/detectors/latest#endpoint-create-single-detector) _Expand the "rules" section, then expand the "notifications" section. From there, select OpsGenie Alert Notification for specifics on sending your alerts to OpsGenie._

### SignalFlow Reference Documentation
Charts plots and Detectors are built using SignalFlow, the statistical engine that powers Splunk observability Cloud.  It's incredibly powerful and therefore some background on how it works can be helpful when defining how a Chart or Detector is built.  Reference to its syntax is [here](https://dev.splunk.com/observability/docs/signalflow/).