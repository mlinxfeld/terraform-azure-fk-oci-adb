resource "azapi_resource" "autonomous_db" {
  type                      = "Oracle.Database/autonomousDatabases@2023-09-01"
  parent_id                 = azurerm_resource_group.FoggyKitchen_Resource_Group.name
  name                      = "fkadb"
  schema_validation_enabled = false
 
  timeouts {
    create = "3h"
    update = "2h"
    delete = "1h"
  }
 
  body = {
    "location" : "eastus",
    "properties" : {
      "displayName" : "fkadb",
      "computeCount" : 1,
      "dataStorageSizeInTbs" : 1,
      "adminPassword" : "BEstrO0ng_#11",
      "dbVersion" : "19c",
      "licenseModel" : "LicenseIncluded",
      "dataBaseType" : "Regular",
      "computeModel" : "ECPU",
      "dbWorkload" : "DW",
      "permissionLevel" : "Restricted",
 
      "characterSet" : "AL32UTF8",
      "ncharacterSet" : "AL16UTF16",
 
      "isAutoScalingEnabled" : true,
      "isAutoScalingForStorageEnabled" : false,
 
      "vnetId" : azurerm_virtual_network.FoggyKitchen_VNet.id
      "subnetId" : azurerm_subnet.FoggyKitchen_Private_Subnet.id
    }
  }
  response_export_values = ["id", "properties.ocid", "properties"]
}