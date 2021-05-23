
provider "azurerm" {
  alias = "auditing"
  subscription_id            = var.sql_database_auditing_logs_storage_account_subscription != "" ? var.sql_database_auditing_logs_storage_account_subscription : var.subscription_id
  tenant_id                  = var.tenant_id
  client_id                  = var.client_id
  client_secret              = var.client_secret
  skip_provider_registration = true
  features {}
}


data "azurerm_storage_account" "auditing" {
  count               = var.sql_database_auditing_enabled ? 1 : 0
  provider            = azurerm.auditing
  name                = var.sql_database_auditing_storage_account_name
  resource_group_name = var.sql_database_auditing_storage_account_resource_group_name
}


resource "azurerm_mssql_database_extended_auditing_policy" "auditing" {
  depends_on = [
    azurerm_mssql_server.db-server,
    azurerm_mssql_database.db,
    azurerm_mssql_elasticpool.Vcore,
    azurerm_mssql_elasticpool.DTU
  ]

  for_each                                = var.sql_database_auditing_enabled ? { for i in var.sql_database : i.db_name => i.db_name } : {}
  database_id                             = azurerm_mssql_database.db[each.value].id
  storage_endpoint                        = data.azurerm_storage_account.auditing[*].primary_blob_endpoint
  storage_account_access_key              = data.azurerm_storage_account.auditing[*].primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = var.sql_database_auditing_retention_days
}