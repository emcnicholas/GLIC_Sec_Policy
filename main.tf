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

# FMCv
provider "fmc" {
  fmc_username = var.fmc_user
  fmc_password = var.fmc_pass
  fmc_host = var.fmc_host
  fmc_insecure_skip_verify = true
}

