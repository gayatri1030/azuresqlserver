resource "azurerm_mssql_database" "db" {
  for_each   = { for i in var.sql_database : i.db_name => i.db_name }
  depends_on = [
    azurerm_mssql_server.db-server
  ]
  name             = lookup({for i in var.sql_database: i.db_name => i.db_name}, each.value)
  server_id        = azurerm_mssql_server.db-server.id
  collation        = lookup({for i in var.sql_database: i.db_name => i.db_collation}, each.value)
  sku_name         = lookup({for i in var.sql_database: i.db_name => i.db_sku_name}, each.value)
  max_size_gb      = lookup({for i in var.sql_database: i.db_name => i.db_max_size_gb}, each.value)
  zone_redundant   = lower(lookup({for i in var.sql_database: i.db_name => i.db_edition}, each.value)) == "premium" || lower(lookup({for i in var.sql_database: i.db_name => i.db_edition},each.value)) == "businesscritical" ? lookup({for i in var.sql_database: i.db_name => i.db_zone_redundancy_enabled},each.value) : false
  tags             = var.tags

  short_term_retention_policy {
    retention_days = "7"
  }
}

