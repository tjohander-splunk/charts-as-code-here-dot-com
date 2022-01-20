variable "access_token" {
  description = "Splunk Access Token"
}

variable "realm" {
  description = "Splunk Realm"
}

variable "sfx_prefix" {
  type        = string
  description = "Prefix for Various Resources"
  default     = "[Splunk]"
}

variable "opsgenie_api_key" {
  type = string
  default = "API Key for OpsGenie"
}