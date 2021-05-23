resource "azurerm_sql_firewall_rule" "allow-azure-services" {
  depends_on = [
    azurerm_mssql_server.db-server
  ]
  count               = var.sql_firewall_allow_azure_services ? 1 : 0
  name                = "Allow Azure Services"
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.db-server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_firewall_rule" "user-defined" {
  depends_on = [
    azurerm_mssql_server.db-server
  ]
  for_each            = { for i in var.sql_firewall_rules : i.rule_name => i.rule_name }
  name                = lookup({for i in var.sql_firewall_rules: i.rule_name => i.rule_name}, each.value)
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.db-server.name
  start_ip_address    = lookup({for i in var.sql_firewall_rules: i.rule_name => i.start_ip}, each.value)
  end_ip_address      = lookup({for i in var.sql_firewall_rules: i.rule_name => i.end_ip}, each.value)
}