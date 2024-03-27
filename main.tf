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

resource "azurerm_resource_group" "example" {
  name     = format("rg-NAHUM-%d", random_integer.example.result)
  location = "West Europe"
}

resource "random_integer" "nah" {
  min = 1000
  max = 9999
}

resource "azurerm_app_service_plan" "gil" {
  name                = format("asp-NAHUM-%d", random_integer.example.result)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_linux_web_app" "gio" {
  name                = format("webapp-NAHUM-%d", random_integer.example.result)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  site_config {
    java_version       = "java17"
    java_server        = "JAVA"
    java_server_version = "17"
  }
}


