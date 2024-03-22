variable "GOOGLE_CREDENTIALS" {
  type = string
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "webapp_subnet_name" {
  type = string
}

variable "db_subnet_name" {
  type = string
}

variable "web_subnet_cidr_range" {
  type = string
}

variable "db_subnet_cidr_range" {
  type = string
}

variable "routing_mode" {
  type = string
}

variable "default-route" {
  type = string
}

variable "route_dest_range" {
  type = string
}

variable "route_next_hop" {
  type = string
}

variable "zone" {
  type = string
}

variable "firewall_name" {
  type = string
}

variable "allowed_protocol" {
  type = string
}

variable "network" {
  type = string
}

variable "instance_tags" {
  type = list(string)
}

variable "vm_instance_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "image" {
  type = string
}

variable "boot_disk_size_gb" {
  type = number
}

variable "boot_disk_type" {
  type = string
}

variable "deny_protocol" {
  type = string
}

variable "firewall_name_allow_traffic" {
  description = "Name of the firewall rule to allow traffic"
  default     = "allow-traffic"
}

variable "firewall_name_deny_all" {
  description = "Name of the firewall rule to deny all traffic"
  default     = "deny-all"
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(string)
}



variable "deny_ports" {
  description = "List of allowed ports"
  type        = list(string)
}
variable "source_ranges" {
  description = "List of source IP ranges"
  type        = list(string)
}

variable "cloudsql_instance_name" {
  description = "Name of the CloudSQL instance"
  type        = string
}

variable "cloudsql_database_version" {
  description = "Database version for CloudSQL instance"
  type        = string
}


variable "availability_type" {
  description = "CloudSQL instance availability type"
  type        = string
}

variable "cloudsql_disk_type" {
  description = "CloudSQL instance disk type"
  type        = string
}

variable "cloudsql_disk_size" {
  description = "CloudSQL instance disk size"
  type        = string
}

variable "cloudsql_ipv4_enabled" {
  description = "CloudSQL instance ipv4"
  type        = bool
}

variable "cloudsql_tier" {
  description = "CloudSQL instance tier"
  type        = string
}

variable "cloudsql_database" {
  description = "CloudSQL database"
  type        = string
}

variable "sql_name" {
  description = "SQL name"
  type        = string
}

variable "global_address_name" {
  description = "The name of the global address"
  default     = "global-psconnect-ip"
}

variable "address_type" {
  description = "The type of the global address"
  default     = "INTERNAL"
}

variable "purpose" {
  description = "The purpose of the global address"
  default     = "VPC_PEERING"
}

variable "prefix_length" {
  description = "The prefix length of the global address"
  default     = 24
}

variable "db_instance_name" {
  description = "The name of the Cloud SQL database instance"
  default     = "webapp-sqldb"
}

variable "database_version" {
  description = "The version of the database"
  default     = "MYSQL_5_7"
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled for the instance"
  default     = false
}

variable "disk_type" {
  description = "The type of disk for the instance"
  default     = "PD_SSD"
}

variable "disk_size_gb" {
  description = "The size of the disk in GB"
  default     = 100
}

variable "tier" {
  description = "The machine tier for the instance"
  default     = "db-custom-1-3840"
}

variable "activation_policy" {
  description = "The activation policy for the instance"
  default     = "ALWAYS"
}

variable "ipv4_enabled" {
  description = "Whether IPv4 is enabled for the instance"
  default     = false
}


variable "backup_enabled" {
  description = "Whether backup is enabled for the instance"
  default     = true
}

variable "binary_log_enabled" {
  description = "Whether binary logging is enabled for the instance"
  default     = true
}

variable "dns_zone_name" {
  type = string
}

variable "dns_record_name" {
  type = string
}

variable "dns_record_type" {
  type = string
}

variable "dns_record_ttl" {
  type = number
}

variable "service_account_account_id" {
  type = string
}

variable "service_account_display_name" {
  type = string
}
