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
resource "azurerm_service_plan" "gio" {
  name                = format("rg-NAHUM-%d", random_integer.nah.result)
  location            = azurerm_resource_group.nah.location
  resource_group_name = azurerm_resource_group.nah.name
  os_type             = "Linux"
  sku_name            = "B1"
}
resource "azurerm_linux_web_app" "nahgio" {
  name                = format("webapp-NAHUM-%d", random_integer.nah.result)
  location            = azurerm_resource_group.nah.location
  resource_group_name = azurerm_resource_group.nah.name
  service_plan_id     = azurem_service_plan.gio
  site_config {
         application_stack{
                java_version         = "java17"
                java_server          = "JAVA"
                java_server_version  = "17"
         }
  }
}






