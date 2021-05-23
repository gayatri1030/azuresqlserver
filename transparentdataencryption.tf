#Manages the transparent data encryption configuration for a MSSQL Server
#Customer-Managed Key is not yet configured

resource "azurerm_mssql_server_transparent_data_encryption" "service-managed" {
  server_id = azurerm_mssql_server.db-server.id
}