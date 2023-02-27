/*
resource "azuread_group" "aks-admin" {
  display_name     = "$(azurerm_resource_group.aks-grp.name)-aks-admin"
  mail_enabled     = true
  mail_nickname    = "aks-main-group"
  security_enabled = true
  types            = ["Unified"]
  description      = "Azure AKS Kubernetes administrators for the $(azurerm_resource_group.aks-grp.name)-cluster."

}
*/