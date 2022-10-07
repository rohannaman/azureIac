variable "location" {
  type        = string
  description = "The Azure location to use"
}

variable "resource_prefix" {
  type = string
}

variable "account_tier" {
  type        = string
  description = "Type of storage account"
}

variable "container_access_type" {
  type        = string
  description = "Storage conatiner access type"
}

variable "account_replication_type" {
  type        = string
  description = "Storage account replication type"
}