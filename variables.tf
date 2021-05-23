variable "resource_group_name" {
  type = string
  description = "The name of the resource group that will contain the resources"
}

variable "location" {
  type = string
  description = "The location at which the resource will be created"
}

variable "app_name" {
  default = ""
}

variable "environment" {
  type = string
  description = "The environment in which the resrouce will be created like dev, uat, prod"
}

variable "tags" {
  type = map(string)
}

#Database Server

variable "sql_server_name" {
  type = string
  default = ""
  description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
}

variable "sql_server_admin_name" {
  type = string
  description = "(Required) The administrator login name for the new server. Changing this forces a new resource to be created"
}

variable "sql_server_version" {
  type = string
  description = "(Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)"
  default = "12.0"
}

variable "sql_server_connection_policy" {
  type = string

}

variable "sql_server_minimum_tls_version" {
  type = string
  description = "The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: 1.0, 1.1 and 1.2"
  default = "1.2"
}

variable "sql_server_public_access_enabled" {
  type = bool
  description = "Whether or not public network access is allowed for this server. Defaults to true"
}

variable "sql_server_ad_admin_name" {
  type = string
  description = " (Required) The login username of the Azure AD Administrator of this SQL Server"
}

variable "sql_server_ad_admin_object_id" {
  type = string
  description = "(Required) The object id of the Azure AD Administrator of this SQL Server."
}

#Database
variable "sql_database" {
  type  = list(object({
    use_elastic_pool = bool
    db_name          = string
    db_collation     = string
    db_edition       = string
    db_sku_name      = string
    db_max_size_gb   = number
    db_zone_redundancy_enabled = bool
  }))
  description = "Define the list of databases that needs to be created"
}


#Elastic Pool
variable "sql_database_create_elastic_pool" {
  type = bool
  description = "Whether to create or not a database elastic pool"
}

variable "sql_database_elastic_pool_name" {
  type = string
  description = "(Required) The name of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created"
}

variable "sql_database_elastic_pool_max_size_gb" {
  type = string
  description = "The max data size of the elastic pool in gigabytes"
}

variable "sql_database_elastic_pool_zone_redundant" {
  type = bool
  description = "Whether or not this elastic pool is zone redundant. tier needs to be Premium for DTU based or BusinessCritical for vCore based sku. Defaults to false"
  default = false
}

variable "sql_database_elastic_pool_sku_model" {
  type = string
  description = "The model used to define the sku of elastic pool. Values are DTU or Vcore"
}

variable "sql_database_elastic_pool_sku_tier" {
  type = string
  description = "The sku tier of the elastic pool. For DTU values, valid values are Basic, Standard and Premium. For Vcore values are GeneralPurpose and BusinessCritical"
}

variable "sql_database_elastic_pool_sku_family" {
  type = string
  description = "The sku family of elastic pool. Only applicable for Vcore. Valid values are Gen4 or Gen5"
}

variable "sql_database_elastic_pool_sku_capacity" {
  type = number
  description = "Capacity of elastic pool expressed in cores when Vcore model is used and eDTUs if DTU model is used"
}

variable "sql_database_elastic_pool_maximum_capacity" {
  type = number
  description = "The maximum capacity (DTUs or cores) that all databases with elastic pool are guranteed"
}

variable "sql_database_elastic_pool_minimum_capacity" {
  type = number
  description = "The minimum capacity (DTUs or cores) that all databases with elastic pool are guranteed"
}

#Firewall Rules
variable "sql_firewall_rules" {
  type = list(object({
    rule_name = string
    start_ip  = string
    end_ip    = string
  }))
  description = ""
}

variable "sql_firewall_allow_azure_services" {
  type = bool
}


#Vnet Rules
variable "sql_network_subnet_names" {
  type = list(string)
  description = "A list of subnet names for which to enable access for the database server"
  default = []
}

variable "sql_network_virtual_network_name" {
  type    = string
  description = "The name of the virtual network for which to enable accesss to the database server"
  default = ""
}

variable "sql_network_virtual_network_resource_group_name" {
  type = string
  description = "Resource group name if the virtual newtowrk belongs to a different resource group else it will redirect to the var.resource_group_name"
  default = ""
}

#Auditing Storage Account
variable "sql_database_auditing_enabled" {
  type = bool
  description = "Pass true to enable SQL Database auditing"
  default = false
}

variable "sql_database_auditing_storage_account_name" {
  type = string
  description = "Storage Account name where the auditing logs will be stored"
  default = ""
}

variable "sql_database_auditing_storage_account_resource_group_name" {
  type = string
  description = "Storage Account resource group name where the auditing logs will be stored"
  default = ""
}

variable "sql_database_auditing_logs_storage_account_subscription" {
  type = string
  description = "Storage Account subscription name, if left empty will resdirect to var.subscription_name"
  default = ""
}

variable "sql_database_auditing_retention_days" {
  type = number
  description = "The number of days to retain logs for in the storage account."
}

#Security Alert
variable "sql_server_security_alert_email_address" {
  type = list(string)
  description = " Specifies an array of e-mail addresses to which the alert is sent."
  default = []
}

variable "sql_server_security_alert_retention_days" {
  type = number
  description = "Secifies the number of days to keep in the Threat Detection audit logs"
  default = 90
}

#Vulnerability

variable "sql_vulnerability_assessment_storage_account_subscription" {
  type = string
  description = "Subscription where the vulnerability assessment storage account is present, if not set then will get the value of var.subscription_id"
}

variable "sql_vulnerability_assessment_enabled" {
  type = bool
  description = "To enable SQL vulnerability assessment"
  default = false
}

variable "sql_vulnerability_assessment_storage_account_name" {
  type        = string
  description = "Vulnerability assessment storage account name where the scans will be stored"
}

variable "sql_vulnerability_assessment_storage_account_resource_group_name" {
  type = string
  description = "Storage account resource group name for vulnerability assessment"
}

variable "sql_vulnerability_assessment_email_list" {
  type = list(string)
  description = " Specifies an array of e-mail addresses to which the scan notification is sent"
}

variable "sql_vulnerability_assessment_storage_container_name" {
  type = string
  description = "(Required) A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/)."
}


#Subscription
variable "subscription_id" {
  type = string
  description = "Azure subscription id"
}

variable "client_id" {
  type = string
  description = "Service principal Client ID"
}

variable "client_secret" {
  type = string
  description = "Service Principal Client Secret"
}

variable "tenant_id" {
  type = string
  description = "Azure tenant ID"
}

