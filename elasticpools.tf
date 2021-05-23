locals {
   sku_tier_vcore  = lower(var.sql_database_elastic_pool_sku_model) == "vcore" && lower(var.sql_database_elastic_pool_sku_tier) == "generalpurpose" ? "GP" : "BC"
   sku_name_vcore  = "${upper(local.sku_tier_vcore)}_${var.sql_database_elastic_pool_sku_family}"
   sku_name_dtu    = lower(var.sql_database_elastic_pool_sku_model) == "dtu" && lower(var.sql_database_elastic_pool_sku_tier) == "basic" ? "BasicPool" : (lower(var.sql_database_elastic_pool_sku_model) == "dtu" && lower(var.sql_database_elastic_pool_sku_tier) == "standard" ? "StandardPool" : "PremiumPool")
}

#Elastic Pool for Vcore sku model
resource "azurerm_mssql_elasticpool" "Vcore" {
  count    = var.sql_database_create_elastic_pool && lower(var.sql_database_elastic_pool_sku_model) == "vcore" ? 1 : 0
  depends_on = [
    azurerm_mssql_server.db-server
  ]
  location            = var.location
  name                = var.sql_database_elastic_pool_name
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.db-server.name
  max_size_gb         = var.sql_database_elastic_pool_max_size_gb
  zone_redundant      = var.sql_database_elastic_pool_zone_redundant && lower(var.sql_database_elastic_pool_sku_tier) == "businesscritical" ? true : false

  sku {
    name     = local.sku_name_vcore
    tier     = var.sql_database_elastic_pool_sku_tier
    capacity = var.sql_database_elastic_pool_sku_capacity
  }

  per_database_settings {
    max_capacity = var.sql_database_elastic_pool_maximum_capacity
    min_capacity = var.sql_database_elastic_pool_minimum_capacity
  }

  tags = var.tags

}

#Elastic Pool for DTU sku model

resource "azurerm_mssql_elasticpool" "DTU" {
  count    = var.sql_database_create_elastic_pool && lower(var.sql_database_elastic_pool_sku_model) == "dtu" ? 1 : 0
  depends_on = [
    azurerm_mssql_server.db-server
  ]
  location            = var.location
  name                = var.sql_database_elastic_pool_name
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.db-server.name
  max_size_gb         = var.sql_database_elastic_pool_max_size_gb
  zone_redundant      = var.sql_database_elastic_pool_zone_redundant && lower(var.sql_database_elastic_pool_sku_tier) == "businesscritical" ? true : false

  sku {
    name     = local.sku_name_dtu
    tier     = var.sql_database_elastic_pool_sku_tier
    capacity = var.sql_database_elastic_pool_sku_capacity
  }

  per_database_settings {
    max_capacity = var.sql_database_elastic_pool_maximum_capacity
    min_capacity = var.sql_database_elastic_pool_minimum_capacity
  }

  tags = var.tags
}