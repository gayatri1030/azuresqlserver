
data "azurerm_subnet" "db-network-rule-subnets" {
  count = var.sql_server_public_access_enabled ? length(var.sql_network_subnet_names) : 0
  name  = var.sql_network_subnet_names[count.index]
  virtual_network_name = var.sql_network_virtual_network_name
  resource_group_name  = var.sql_network_virtual_network_resource_group_name != "" ? var.sql_network_virtual_network_resource_group_name : var.resource_group_name
}

resource "azurerm_sql_virtual_network_rule" "db-network-rule" {
  count               = var.sql_server_public_access_enabled ? length(var.sql_network_subnet_names) : 0
  depends_on          = [
    azurerm_mssql_server.db-server
  ]
  name                = "dbvnetrule-${var.sql_network_subnet_names[count.index]}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.db-server.name
  subnet_id           = data.azurerm_subnet.db-network-rule-subnets[count.index].id
}