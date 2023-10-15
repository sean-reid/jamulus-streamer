resource "google_compute_instance" "jamulus_instance" {
  name         = "jamulus-instance"
  machine_type = var.instance_type
  zone         = "${var.region}-a"

  metadata = {
    ssh-keys = "ubuntu:${file(var.key_path)}"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-pro-cloud/ubuntu-pro-1804-lts"
    }
  }

  network_interface {
    network    = google_compute_network.jamulus_network.name
    subnetwork = google_compute_subnetwork.jamulus_subnet.name

    access_config {
      nat_ip = google_compute_address.jamulus_external_ip.address
    }
  }
}
