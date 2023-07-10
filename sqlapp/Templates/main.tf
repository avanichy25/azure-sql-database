terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}


provider "azurerm" {
    client_id= "984a89b3-f288-4050-b9d3-fe492aed1e55"
    client_secret= "QYY8Q~JSjtMTXQJKDTcDi_pW-ARe3-2DT0ifEbyZ"
    tenant_id= "ad1e5f27-489b-4bad-a209-f3b5741fd81c"
    subscription_id = "058bc466-7900-46a0-9403-eb04e3388a62"
    features {

    }
  
}


resource "azurerm_service_plan" "plan787877" {
  name                = "plan787877"
  resource_group_name = "template-grp"
  location            = "East US"
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "newapp777" {
  name                = "newapp777"
  resource_group_name = "template-grp"
  location            = "East US"
  service_plan_id     = azurerm_service_plan.plan787877.id

  site_config {
    always_on = false
    application_stack{
        current_stack="dotnet"
        dotnet_version="v6.0"
    }
  }

  depends_on = [ azurerm_service_plan.plan787877 ]

}

resource "azurerm_mssql_server" "sqlserver7877" {
  name                         = "sqlserver7877"
  resource_group_name          = "template-grp"
  location                     = "East US"
  version                      = "12.0"
  administrator_login          = "sqlusr"
  administrator_login_password = "sqlpassword123#"
}

resource "azurerm_mssql_database" "appdb" {
  name                = "appdb"
  server_id           =  azurerm_mssql_server.sqlserver7877.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  license_type        = "LicenseIncluded"
  max_size_gb         = 2
  sku_name            = "Basic"
  depends_on = [ azurerm_mssql_server.sqlserver7877 ]
}
