provider "google" {
  credentials = file(var.GOOGLE_CREDENTIALS)
  project     = var.project_id
  region      = var.region
}

resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  delete_default_routes_on_create = true
  auto_create_subnetworks         = false
  routing_mode                    = var.routing_mode
}

resource "google_compute_subnetwork" "webapp_subnet" {
  name                     = var.webapp_subnet_name
  ip_cidr_range            = var.web_subnet_cidr_range
  network                  = google_compute_network.vpc_network.self_link
  region                   = var.region
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "db_subnet" {
  name                     = var.db_subnet_name
  ip_cidr_range            = var.db_subnet_cidr_range
  network                  = google_compute_network.vpc_network.self_link
  region                   = var.region
  private_ip_google_access = true

}

resource "google_compute_route" "default_route" {
  name             = var.default-route
  network          = google_compute_network.vpc_network.self_link
  dest_range       = var.route_dest_range
  next_hop_gateway = var.route_next_hop
}


resource "google_compute_global_address" "global_address" {
  project       = var.project_id
  name          = var.global_address_name
  address_type  = var.address_type
  purpose       = var.purpose
  network       = google_compute_network.vpc_network.self_link
  prefix_length = var.prefix_length
}

resource "google_service_networking_connection" "service-access" {
  depends_on              = [google_compute_global_address.global_address]
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.global_address.name]
}
resource "random_id" "dbinst_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "db_instance" {
  name                = "webapp-sqldb-${random_id.dbinst_name_suffix.hex}"
  database_version    = var.database_version
  deletion_protection = var.deletion_protection

  depends_on = [google_service_networking_connection.service-access]

  settings {
    disk_type         = var.disk_type
    disk_size         = var.disk_size_gb
    tier              = var.tier
    activation_policy = var.activation_policy
    availability_type = var.availability_type

    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = google_compute_network.vpc_network.self_link
    }

    backup_configuration {
      enabled            = var.backup_enabled
      binary_log_enabled = var.binary_log_enabled
    }
  }
}
# CloudSQL Database
resource "google_sql_database" "cloudsql_db" {
  name     = "webapp"
  instance = google_sql_database_instance.db_instance.name
}
# CloudSQL Database User
resource "random_password" "database_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
resource "google_sql_user" "database_user" {
  name     = "webapp"
  instance = google_sql_database_instance.db_instance.name
  password = random_password.database_password.result
}

# data "google_service_account" "existing_service_account" {
#   account_id = "362973774723-compute@developer.gserviceaccount.com"  # Replace with the ID of your existing service account
# }


resource "google_service_account" "service_account" {
  account_id   = var.service_account_account_id
  display_name = var.service_account_display_name
}


resource "google_project_iam_binding" "logging_admin" {
  project = var.project_id
  role    = "roles/logging.admin"

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}

resource "google_project_iam_binding" "monitoring_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    auto_delete = true
    initialize_params {
      image = var.image
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }
  }

  metadata_startup_script = <<-EOT
#!/bin/bash
echo "Hello World!"

sudo echo "DATABASE=${google_sql_database.cloudsql_db.name}" | sudo tee -a /opt/webapp/.env

sudo echo "HOST=${google_sql_database_instance.db_instance.private_ip_address}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_PASSWORD=${google_sql_user.database_user.password}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_USERNAME=${google_sql_user.database_user.name}" | sudo tee -a /opt/webapp/.env

EOT

  network_interface {
    subnetwork = google_compute_subnetwork.webapp_subnet.self_link
    access_config {

    }
  }

  service_account {
    email = google_service_account.service_account.email
    //email = data.google_service_account.existing_service_account.email
    scopes = ["cloud-platform"]
  }



  depends_on = [google_compute_firewall.allow_traffic, google_compute_subnetwork.webapp_subnet]

  tags = var.instance_tags

  allow_stopping_for_update = true
}

data "google_dns_managed_zone" "existing_zone" {
  name = var.dns_zone_name
}

resource "google_dns_record_set" "dns_record" {
  name         = var.dns_record_name
  type         = var.dns_record_type
  ttl          = var.dns_record_ttl
  managed_zone = data.google_dns_managed_zone.existing_zone.name
  # rrdatas = [google_compute_instance.vm_CloudComputing.network_interface.0.access_config.0.nat_ip]
  rrdatas    = [google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip]
  depends_on = [google_compute_instance.vm_instance]
}