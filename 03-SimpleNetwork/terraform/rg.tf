resource "azurerm_resource_group" "rg" {
  name     = "rg-simplenetwork-dev-sea-${random_integer.suffix.result}"
  location = "southeastasia"
}
