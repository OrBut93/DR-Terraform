
################################
#REGION
################################

## this defined the Region for VM ## 
variable "zone" {
  default = "europe-west3-c"
}

##This defind the Zone for VPC##
variable "region" {
    default = "europe-west3"
  
}

################################
#CREDENTIALS
################################
variable "backup_service_account_key_path" {
  description = "Backup project - The path to the service account key file"
  type        = string
}


variable "network_service_account_key_path" {
  description = "Network project - The path to the service account key file"
  type        = string

}


variable "production_service_account_key_path" {
  description = "Production project - The path to the service account key file"
  type        = string

}


################################
#PROJECTS ID
################################

variable "backup_project_id" {
  default = ""  
}

variable "network_project_id" {
  default = ""  
}

variable "production_project_id" {
  default = ""  
}


################################
#VPCS NAMES
################################

variable "vpc_backup" {
  default = ""
}

variable "vpc_network" {
  default = ""
}

variable "vpc_production" {
  default = ""
}

################################
#SUBNETS NAMES & CIDR
################################

variable "subnet_backup" {
  default = ""
}

variable "subnet_network" {
  default = ""
}

variable "subnet_production" {
  default = ""
}

variable "subnet_backup_ip_cidr_range" {
  default = ""
}

variable "subnet_network_ip_cidr_range" {
  default = ""
}

variable "subnet_production_ip_cidr_range" {
  default = ""
}
