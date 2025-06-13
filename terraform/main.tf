provider "azurerm" {
  features {}
}

# Reference existing Resource Group instead of creating one
data "azurerm_resource_group" "aks_rg" {
  name = "pkm-13-06"
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "kpkm-aks-cluster"
  location            = data.azurerm_resource_group.aks_rg.location
  resource_group_name = data.azurerm_resource_group.aks_rg.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  tags = {
    environment = "dev"
  }
}
