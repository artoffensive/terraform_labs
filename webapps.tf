resource "azurerm_resource_group" "webapp-rg" {
    name = "WebApps-RG"
    location     = "${var.loc}"
    tags         = "${var.tags}"
  
}

resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
    count               = "${length(var.webapplocs)}"
    name                = "plan-free-${var.webapplocs[count.index]}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapp-rg.name}"
    tags                = "${azurerm_resource_group.webapp-rg.tags}"

    kind                = "Linux"
    sku {
        tier = "Free"
        size = "F1"
    }
}

resource "azurerm_app_service" "citadel" {
    count               = "${length(var.webapplocs)}"
    name                = "webapp-${random_string.webapprnd.result}-${var.webapplocs[count.index]}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapp-rg.name}"
    tags                = "${azurerm_resource_group.webapp-rg.tags}"

    app_service_plan_id = "${element(azurerm_app_service_plan.free.*.id, count.index)}"
}

output "webapp_hostnames" {
    description         =   "A list of the default site hostnames"
    value               = "${azurerm_app_service.citadel.*.default_site_hostname}"
}
