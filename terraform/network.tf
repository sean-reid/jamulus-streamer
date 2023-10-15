resource "google_compute_network" "jamulus_network" {
  name = "jamulus-vpc"
}

resource "google_compute_subnetwork" "jamulus_subnet" {
  name          = "jamulus-subnet"
  network       = google_compute_network.jamulus_network.self_link
  region        = var.region
  ip_cidr_range = var.subnet_cidr
}

resource "google_compute_address" "jamulus_external_ip" {
  name         = "jamulus-external-ip"
  address_type = "EXTERNAL"
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.jamulus_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.allowed_source_ranges
}

resource "google_compute_firewall" "allow-jamulus" {
  name    = "allow-jamulus"
  network = google_compute_network.jamulus_network.name

  allow {
    protocol = "udp"
    ports    = ["22124"]
  }

  source_ranges = var.allowed_source_ranges
}
