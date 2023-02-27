/*
resource "azurerm_virtual_network" "aks-vnet" {
  name                = "aks-vnet"
  resource_group_name = azurerm_resource_group.aks-grp.name
  location            = azurerm_resource_group.aks-grp.location
  address_space       = ["10.11.0.0/16"]
}
resource "azurerm_subnet" "aks-default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.aks-grp.name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes     = ["10.11.1.0/24"]
  }



resource "azurerm_subnet" "aks-aci" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.aks-grp.name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes     = ["10.11.0.0/24"]
  delegation {
    name = "aciDelegetion"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

}

*/