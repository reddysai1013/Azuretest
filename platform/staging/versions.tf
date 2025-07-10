terraform {
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94.1"
    }
    coralogix = {
      version = "~> 2.0.20"
      source  = "coralogix/coralogix"
    }
  }
}

