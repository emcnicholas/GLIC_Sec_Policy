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
data "fmc_access_policies" "acp" {
    name = "GLIC-Access-Policy"
}
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

# Access Control Policy Rules
#########################################################

#resource "fmc_access_rules" "access_rule_1" {
#    depends_on = [data.fmc_access_policies.acp]
#    acp                = data.fmc_access_policies.acp.id
#    section            = "mandatory"
#    name               = "Dev App1 Outbound Access"
#    action             = "allow"
#    enabled            = true
#    send_events_to_fmc = true
#    log_files          = false
#    log_begin          = true
#    log_end            = true
#    source_dynamic_objects {
#        source_dynamic_object {
#            id   = data.fmc_dynamic_objects.dev_app1.id
#            type = "DynamicObject"
#        }
#    }
#    destination_ports {
#        destination_port {
#            id = data.fmc_port_objects.http.id
#            type = "TCPPortObject"
#        }
#        destination_port {
#            id = data.fmc_port_objects.https.id
#            type = "TCPPortObject"
#        }
#    }
#    ips_policy   = fmc_ips_policies.ips_policy.id
#    new_comments = ["Dev outbound web traffic"]
#}
#
#resource "fmc_access_rules" "access_rule_2" {
#    depends_on = [data.fmc_access_policies.acp]
#    acp                = data.fmc_access_policies.acp.id
#    section            = "mandatory"
#    name               = "Prod App1 Outbound Access"
#    action             = "allow"
#    enabled            = true
#    send_events_to_fmc = true
#    log_files          = false
#    log_begin          = true
#    log_end            = true
#    source_dynamic_objects {
#        source_dynamic_object {
#            id   = data.fmc_dynamic_objects.prod_app1.id
#            type = "DynamicObject"
#        }
#    }
#    destination_ports {
#        destination_port {
#            id = data.fmc_port_objects.http.id
#            type = "TCPPortObject"
#        }
#        destination_port {
#            id = data.fmc_port_objects.https.id
#            type = "TCPPortObject"
#        }
#        destination_port {
#            id = data.fmc_port_objects.ssh.id
#            type = "TCPPortObject"
#        }
#    }
#    ips_policy   = fmc_ips_policies.ips_policy.id
#    new_comments = ["Dev outbound web traffic"]
#}
#
#resource "fmc_access_rules" "access_rule_3" {
#    depends_on = [data.fmc_access_policies.acp]
#    acp                = data.fmc_access_policies.acp.id
#    section            = "mandatory"
#    name               = "Deny Any Any"
#    action             = "block"
#    enabled            = true
#    send_events_to_fmc = true
#    log_files          = false
#    log_begin          = true
#    new_comments = ["Deny Any"]
#}



