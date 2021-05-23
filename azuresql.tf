terraform {
  backend "azurerm" { }
}

module "sql-database" {
  source = "../../Terraform_Modules/AzureSQLServer"

  #Common variables
  resource_group_name = var.usr_resource_group_name
  location            = var.usr_location
  environment         = var.usr_environment

  #Provider Variables
  client_id       = var.usr_client_id
  client_secret   = var.usr_client_secret
  subscription_id = var.usr_subscription_id
  tenant_id       = var.usr_tenant_id

  #SQL Server Name
  sql_server_ad_admin_name         = var.usr_sql_server_ad_admin_name
  sql_server_ad_admin_object_id    = var.usr_sql_server_ad_admin_object_id
  sql_server_admin_name            = var.usr_sql_server_admin_name
  sql_server_connection_policy     = var.usr_sql_server_connection_policy
  sql_server_name                  = var.usr_sql_server_name
  sql_server_public_access_enabled = var.usr_sql_server_public_access_enabled

  #SQL Database variables
  sql_database = var.usr_sql_database

  ## SQL Database Elastic Pool
  sql_database_create_elastic_pool           = var.usr_sql_database_create_elastic_pool
  sql_database_elastic_pool_maximum_capacity = var.usr_sql_database_elastic_pool_maximum_capacity
  sql_database_elastic_pool_minimum_capacity = var.usr_sql_database_elastic_pool_minimum_capacity
  sql_database_elastic_pool_name             = var.usr_sql_database_elastic_pool_name
  sql_database_elastic_pool_sku_capacity     = var.usr_sql_database_elastic_pool_sku_capacity
  sql_database_elastic_pool_sku_family       = var.usr_sql_database_elastic_pool_sku_family
  sql_database_elastic_pool_sku_model        = var.usr_sql_database_elastic_pool_sku_model
  sql_database_elastic_pool_sku_tier         = var.usr_sql_database_elastic_pool_sku_tier
  sql_database_elastic_pool_max_size_gb      = var.usr_sql_database_elastic_pool_max_size_gb

  ##SQL Firewall
  sql_firewall_allow_azure_services               = var.usr_sql_firewall_allow_azure_services
  sql_firewall_rules                              = var.usr_sql_firewall_rules
  sql_network_subnet_names                        = var.usr_sql_network_subnet_names
  sql_network_virtual_network_resource_group_name = var.usr_sql_network_virtual_network_resource_group_name
  sql_network_virtual_network_name                = var.usr_sql_network_virtual_network_name

  #SQL Database Auditing
  sql_database_auditing_enabled                             = var.usr_sql_database_auditing_enabled
  sql_database_auditing_logs_storage_account_subscription   = var.usr_sql_database_auditing_logs_storage_account_subscription
  sql_database_auditing_storage_account_name                = var.usr_sql_database_auditing_storage_account_name
  sql_database_auditing_storage_account_resource_group_name = var.usr_sql_database_auditing_storage_account_resource_group_name
  sql_database_auditing_retention_days                      = var.usr_sql_database_auditing_retention_days

  #SQL Vulnerability Assessment
  sql_vulnerability_assessment_enabled                             = var.usr_sql_vulnerability_assessment_enabled
  sql_vulnerability_assessment_email_list                          = var.usr_sql_vulnerability_assessment_email_list
  sql_vulnerability_assessment_storage_account_name                = var.usr_sql_vulnerability_assessment_storage_account_name
  sql_vulnerability_assessment_storage_account_resource_group_name = var.usr_sql_vulnerability_assessment_storage_account_resource_group_name
  sql_vulnerability_assessment_storage_account_subscription        = var.usr_sql_vulnerability_assessment_storage_account_subscription
  sql_vulnerability_assessment_storage_container_name              = var.usr_sql_vulnerability_assessment_storage_container_name

  #SQL Security Alerts
  sql_server_security_alert_email_address  = var.usr_sql_server_security_alert_email_address
  sql_server_security_alert_retention_days = var.usr_sql_server_security_alert_retention_days

  #Tags
  tags = {}
}