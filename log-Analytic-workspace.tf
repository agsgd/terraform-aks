resource "azurerm_log_analytics_workspace" "aks-loganal" {
  name                = "aksloganalyticsgabbar"
  location            = azurerm_resource_group.aks-grp.location
  resource_group_name = azurerm_resource_group.aks-grp.name
  retention_in_days   = 30

}

/*
resource "azurerm_log_analytics_solution" "aks-log-sol" {
  solution_name         = "conatainers"
  workspace_resource_id = azurerm_log_analytics_workspace.aks-loganal.id
  resource_group_name   = azurerm_resource_group.aks-grp.name
  location              = azurerm_resource_group.aks-grp.location
  workspace_name        = azurerm_log_analytics_workspace.aks-loganal.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }

}
*/