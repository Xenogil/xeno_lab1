terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}
resource "random_integer" "nah" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "nah" {
  name     = format("rg-NAHUM-%d", random_integer.nah.result)
  location = "West Europe"
}
resource "azurerm_app_service_plan" "gil" {
  name                = format("asp-NAHUM-%d", random_integer.nah.result)
  location            = azurerm_resource_group.nah.location
  resource_group_name = azurerm_resource_group.nah.name
  kind             = "Linux"
  sku {
    tier = "Basic"
    size = "B1"
  }
}
resource "azurerm_linux_web_app" {
  name                = format("webapp-NAHUM-%d", random_integer.nah.result)
  location            = azurerm_resource_group.nah.location
  resource_group_name = azurerm_resource_group.nah.name
}





