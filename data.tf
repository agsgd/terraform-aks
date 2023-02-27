data "azurerm_kubernetes_service_versions" "current" {
  location        = azurerm_resource_group.aks-grp.location
  include_preview = false
}
