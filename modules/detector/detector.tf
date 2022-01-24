# Easily trigger this detector by changing the signal to be > 200 3s and applying to Terraform engine
resource "signalfx_detector" "transaction_latency" {

  name        = "${var.sfx_prefix} TSJ Tokyo Datacenter Transaction Latency"
  description = "Transaction Latency From Tokyo Datacenter"
  max_delay   = 30
  tags        = ["app-backend", "staging"]

  program_text = <<-EOF
        signal = data('demo.trans.latency', filter=filter('demo_datacenter', 'Tokyo'), rollup='average').mean(by=['demo_datacenter'])
        detect(when(signal > 215, '10s')).publish('Transaction Latency High in Tokyo Datacenter')
    EOF
  rule {
    description   = "maximum > 215 for 5s"
    severity      = "Warning"
    detect_label  = "Transaction Latency High in Tokyo Datacenter"
    notifications = ["Email,tjohander@splunk.com"]
  }
}