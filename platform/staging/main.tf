terraform {
  backend "s3" {
    region       = "TODO"
    bucket       = "TODO"
    key          = "TODO"
    encrypt      = true
    use_lockfile = true
  }
}

locals {
  environment     = "staging"
  environment_tag = "STG"
}