terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.43.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.33.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}
resource "azurerm_resource_group" "aks-grp" {
  name     = "aks-grp30"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster_node_pool" "aks-user" {
  name                  = "aksuser"
  vm_size               = "standard_B2S"
  node_count            = 1
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-cluster.id
  orchestrator_version  = "1.24.9"
  os_type               = "Linux"
  node_labels = {
    name = "added-vms"
  }
  tags = {
    "nodepool-type" = "user"
    "environment"   = "prod"
    "nodepoolos"    = "linux"
    "app"           = "java-apps"
  }
}

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.aks-grp.location
  resource_group_name = azurerm_resource_group.aks-grp.name
  dns_prefix          = "exampple"
  kubernetes_version  = "1.24.9"
  #node_resource_group = "$(azurerm_resource_group.aks-grp.name)-ngp"
  role_based_access_control_enabled = true

  default_node_pool {
    name                 = "default"
    node_count           = 1
    vm_size              = "Standard_B2S"
    orchestrator_version = "1.24.9"
    enable_auto_scaling  = true
    max_count            = 2
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    #vnet_subnet_id       = azurerm_subnet.aks-default.id
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
    tags = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
  }
  identity {
    type = "SystemAssigned"
  }
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks-loganal.id
  }
  #aci_connector_linux {
  #ubnet_name = azurerm_subnet.aks-aci.name
  #}
  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = file(var.linux_ssh_key)
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}
