resource "random_password" "admin-password" {
  length           = 16
  special          = true
  override_special = "!$#%"
  min_lower        = 1
  min_numeric      = 1
  min_upper        = 1
  min_special      = 1
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_mssql_server" "db-server" {
  name                          = var.sql_server_name != "" ? "${lower(var.sql_server_name)}-${lower(var.environment)}" : "${var.app_name}-${var.environment}"
  administrator_login           = var.sql_server_admin_name
  administrator_login_password  = random_password.admin-password.result
  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  version                       = var.sql_server_version
  minimum_tls_version           = var.sql_server_minimum_tls_version
  public_network_access_enabled = var.sql_server_public_access_enabled
  connection_policy             = var.sql_server_connection_policy

  azuread_administrator {
    login_username = var.sql_server_ad_admin_name
    object_id      = var.sql_server_ad_admin_object_id
  }

  identity {
    type = "SystemAssigned"
  }


}