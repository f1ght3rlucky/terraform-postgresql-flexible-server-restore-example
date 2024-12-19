provider "azurerm" {
  features {}
  subscription_id = "<YOUR_ID>"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# Existing Server
resource "azurerm_postgresql_flexible_server" "existing" {
  name                         = "example-p2222ostgresql-server"
  location                     = azurerm_resource_group.example.location
  resource_group_name          = azurerm_resource_group.example.name
  administrator_login          = "adminuser"
  administrator_password       = "TRagi517!nmadasdsa%dsadasss"
  version                      = "11"
  sku_name                     = "GP_Standard_D2ds_v5"
  storage_mb                   = 65536
  backup_retention_days        = 7
  zone                         = 3
}

# New Restored Server
resource "azurerm_postgresql_flexible_server" "restored" {
  name                 = "example-restored-postgresql-server"
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  source_server_id     = azurerm_postgresql_flexible_server.existing.id
  sku_name             = "GP_Standard_D2ds_v5"
  storage_mb           = 65536
  backup_retention_days = 7
  zone                 = 3
  administrator_login  = "adminuser"
  administrator_password = "TRagi517!nmadasdsa%dsadasss" 
  version              = "11"
  create_mode          = "PointInTimeRestore" 
  point_in_time_restore_time_in_utc = "2024-12-19T15:14:00Z" 
}

