/******************************************************************************
 * Checkly - health checks are managed via <environment>/sites.csv
 *****************************************************************************/

variable "checkly_account_id" {
  description = "Checkly Account ID"
  type        = string
}

variable "checkly_api_key" {
  description = "Checkly API key"
  type        = string
  sensitive   = true
}

# Checkly Base Module
module "checkly_base" {
  source         = "../modules-euna/checkly/base"
  jira_team_name = local.jira_team_name
  runbook = local.runbook
  account = local.account
  service_name = local.service_name
  service_key  = local.service_key


  checkly_account_id = var.checkly_account_id
  checkly_api_key    = var.checkly_api_key
  environment        = local.environment
  group_name         = "${local.team_name} (${local.environment})"
}

# Checkly API Health Checks
module "checkly_api_health_checks" {
  source = "../modules-euna/checkly/api_health_checks"

  checkly_account_id   = var.checkly_account_id
  checkly_api_key      = var.checkly_api_key
  checkly_group_id     = module.checkly_base.checkly_group_id
  endpoints            = local.api_health_checks
  frequency            = local.api_health_check_frequency
  environment          = local.environment
  application_name     = local.team_name
  monitoring_locations = local.health_check_monitoring_locations

}

/******************************************************************************
 * Coralogix
 *****************************************************************************/

# TODO: integrations

#module "todo_aws_base" {
#  source               = "../modules-euna/coralogix/aws/base"
#
#  application_name     = "todo_${local.environment}"
#  aws_region           = local.aws_accounts.bridge.region
#  resource_tags_filter = ["environment=${local.environment_tag}"]
#  aws_role_name        = "coralogix-metrics-todo-${local.environment}"
#  metric_namespaces    = ["AWS/S3", "AWS/EC2", "AWS/RDS", "AWS/ElastiCache", "AWS/ApplicationELB", "AWS/NetworkELB", "AWS/ECS", "AWS/ES"]
#  aws_account_id       = local.aws_accounts.todo.account_id
#  coralogix_company_id = local.coralogix_company_id
#  external_id          = "todo" 
#}

# TODO: alerting modules

# AWS EC2
#module "aws_ec2" {
#  source = "../modules-euna/coralogix/aws/ec2"
#
#  environment_name = local.environment
#  environment_tag  = local.environment_tag
#}
