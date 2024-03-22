resource "google_compute_firewall" "allow_traffic" {
  name     = "allow-traffic"
  network  = google_compute_network.vpc_network.self_link
  priority = 900
  allow {
    protocol = var.allowed_protocol
    ports    = var.allowed_ports
  }

  target_tags   = var.instance_tags
  source_ranges = var.source_ranges
}

resource "google_compute_firewall" "deny_ssh" {
  name    = "deny-ssh"
  network = google_compute_network.vpc_network.self_link

  deny {
    protocol = var.deny_protocol
    ports    = var.deny_ports
  }

  source_ranges = var.source_ranges
}

# resource "google_compute_firewall" "allow-app-sql" {
#  name    = "allow-app-sql"
#  network = google_compute_network.vpc_network.self_link
#  allow {
#    protocol = "tcp"
#    ports    = ["3306"]
#  }
#  source_tags = ["web", "sql"]
# }