terraform {
  backend "local" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.53.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_resource_group" "this" {
  name     = "rg-example-${random_id.suffix.hex}"
  location = var.location
}

module "storage" {
  source = "./modules/storage"

  resource_group_name = azurerm_resource_group.this.name
  suffix              = random_id.suffix.hex
  location            = var.location
}

module "data_factory" {
  source = "./modules/data-factory"

  resource_group_name = azurerm_resource_group.this.name
  suffix              = random_id.suffix.hex
  location            = var.location
  storage_account_id  = module.storage.storage_account_id

  depends_on = [module.storage]
}
