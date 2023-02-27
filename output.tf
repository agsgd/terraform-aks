output "current_version" {

  value = data.azurerm_kubernetes_service_versions.current.versions
}
output "latest_version" {

  value = data.azurerm_kubernetes_service_versions.current.latest_version
}