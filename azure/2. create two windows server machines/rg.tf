## <https://www.terraform.io/docs/providers/azurerm/r/resource_group.html>
resource "azurerm_resource_group" "rg1" {
  name     = "codescanning1"
  location = var.location
}

## <https://www.terraform.io/docs/providers/azurerm/r/resource_group.html>
resource "azurerm_resource_group" "rg2" {
  name     = "codescanning2"
  location = var.location
}
