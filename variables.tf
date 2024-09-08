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
  default     = "/path/to/your/service-account-key.json"  # Set default or provide value via CLI
}


variable "network_service_account_key_path" {
  description = "Network project - The path to the service account key file"
  type        = string
  default     = "/path/to/your/service-account-key.json"  # Set default or provide value via CLI
}


variable "production_service_account_key_path" {
  description = "Production project - The path to the service account key file"
  type        = string
  default     = "/path/to/your/service-account-key.json"  # Set default or provide value via CLI
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
#
################################