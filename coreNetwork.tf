resource "azurerm_resource_group" "core"{
    name = "Core"
    location = "${var.loc}"
    tags = "${var.tags}"
}

/*
resource "azurerm_public_ip" "vpnGatewayPublicIP"{
    name = "vpnGatewayPublicIP"
    location = "${var.loc}"
    tags = "${var.tags}"

    resource_group_name = "${azurerm_resource_group.core.name}"

    allocation_method   = "Static"
}
*/

resource "azurerm_virtual_network" "core"{
    name = "Core"
    location = "${var.loc}"
    tags = "${var.tags}"

    resource_group_name = "${azurerm_resource_group.core.name}"

    address_space = ["10.0.0.0/16"]
    dns_servers = ["1.1.1.1", "1.0.0.1"]
}

resource "azurerm_subnet" "gatewaysubnet"{
    name = "GatewaySubnet"

    resource_group_name = "${azurerm_resource_group.core.name}"
    virtual_network_name = "${azurerm_virtual_network.core.name}"

    address_prefix = "10.0.0.0/26"
}

resource "azurerm_subnet" "sandboxsubnet"{
    name = "SandboxSubnet"

    resource_group_name = "${azurerm_resource_group.core.name}"
    virtual_network_name = "${azurerm_virtual_network.core.name}"

    address_prefix = "10.0.1.0/24"
}

resource "azurerm_subnet" "devsubnet"{
    name = "devSubnet"

    resource_group_name = "${azurerm_resource_group.core.name}"
    virtual_network_name = "${azurerm_virtual_network.core.name}"

    address_prefix = "10.0.2.0/24"
}

/*
resource "azurerm_virtual_network_gateway" "vpngateway" {
    name = "VPNGateway"
    location = "${var.loc}"
    tags = "${var.tags}"

    resource_group_name = "${azurerm_resource_group.core.name}"

    type     = "Vpn"
    vpn_type = "RouteBased"

    # active_active = false
    enable_bgp    = false
    sku           = "Basic"

    ip_configuration {
        name                          = "vpnGwConfig1"
        public_ip_address_id          = "${azurerm_public_ip.vpnGatewayPublicIP.id}"
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = "${azurerm_subnet.gatewaysubnet.id}"
    }

}
*/
