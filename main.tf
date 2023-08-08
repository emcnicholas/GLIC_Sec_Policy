# Variables
variable "fmc_user" {
  description = "FMC Username"
  type        = string
  sensitive   = true
}
variable "fmc_pass" {
  description = "FMC Password"
  type        = string
  sensitive   = true
}
variable "fmc_host" {
  description = "FMC Hostname or IP address"
  type        = string
}


###################################
# Providers
###################################

terraform {
  required_providers {
    fmc = {
      source = "CiscoDevNet/fmc"
      version = ">=1.2.4"
    }
  }
}

#################################
# FMCv
#################################
provider "fmc" {
  fmc_username = var.fmc_user
  fmc_password = var.fmc_pass
  fmc_host = var.fmc_host
  fmc_insecure_skip_verify = true
}

################################
# Access Policy
################################

# Data Sources
data "fmc_device_cluster" "ftd_cluster-1" {
    name = "ftd_cluster-1"
}
data "fmc_device_cluster" "ftd_cluster-2" {
    name = "ftd_cluster-2"
}
data "fmc_dynamic_objects" "dev_app1" {
    name = "Dev_App1"
}
data "fmc_dynamic_objects" "prod_app1" {
    name = "Prod_App1"
}
data "fmc_network_objects" "internal_cidr" {
    name = "IPv4-Private-10.0.0.0-8"
}
data "fmc_port_objects" "http" {
    name = "HTTP"
}
data "fmc_port_objects" "https" {
    name = "HTTPS"
}
data "fmc_port_objects" "ssh" {
    name = "SSH"
}
data "fmc_ips_policies" "ips_policy" {
    name = "Security Over Connectivity"
}


# IPS Policy
resource "fmc_ips_policies" "ips_policy" {
    name            = "ftdv_ips_policy"
    inspection_mode = "DETECTION"
    basepolicy_id   = data.fmc_ips_policies.ips_policy.id
}

