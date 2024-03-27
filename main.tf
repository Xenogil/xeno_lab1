# Configuration Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

# Fournisseur Azure
provider "azurerm" {
  features {}
}

# Génération d'un nombre entier aléatoire
resource "random_integer" "ex#1" {
  min = 1000
  max = 9999
}

# Création du groupe de ressources Azure
resource "azurerm_resource_group" "ex#2" {
  name     = "rg-NAHUM-${random_integer.example.result}"
  location = "West Europe"
}

# Création du plan App Service
resource "azurerm_app_service_plan" "ex#3" {
  name                = "asp-NAHUM-${random_integer.example.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Création de l'application Web Linux
resource "azurerm_linux_web_app" "example" {
  name                = "webapp-NAHUM-${random_integer.example.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    java_version       = "1.8" # Choisir la version Java appropriée
    java_container     = "TOMCAT" # Remplacer par le conteneur approprié si nécessaire
  }
}

