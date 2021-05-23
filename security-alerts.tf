resource "azurerm_mssql_server_security_alert_policy" "security-alert-policy" {
  resource_group_name        = data.azurerm_resource_group.rg.name
  server_name                = azurerm_mssql_server.db-server.name
  state                      = "Enabled"
  email_account_admins       = true
  email_addresses            = var.sql_server_security_alert_email_address
  retention_days             = var.sql_server_security_alert_retention_days
}