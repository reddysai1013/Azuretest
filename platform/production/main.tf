terraform {
  backend "s3" {
    region      = "us-east-1"
    bucket      = "euna-budget-sherpa-observability"
    key         = "production/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

locals {
  environment     = "production"
  environment_tag = "PRD"

  health_check_monitoring_locations = ["us-east-1", "us-west-1", "ca-central-1"]
  api_health_check_frequency        = 30 # minutes
  site_urls                         = csvdecode(file("${path.module}/sites.csv"))
  api_health_checks                 = [for site in local.site_urls : { url = site.url, priority = "P1", name = "", id = site.url }]
}
