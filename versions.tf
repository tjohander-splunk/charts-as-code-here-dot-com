terraform {
  required_version = ">= 0.13"
  cloud {
    organization = "example-org-bdf487"
  }
  required_providers {
    signalfx = {
      source = "splunk-terraform/signalfx"
    }
  }
}