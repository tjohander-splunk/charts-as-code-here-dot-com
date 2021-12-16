provider "signalfx" {
  auth_token = var.access_token
  api_url    = "https://api.${var.realm}.signalfx.com"
}

module "dashboard" {
  source     = "./modules/dashboard"
  sfx_prefix = var.sfx_prefix
}