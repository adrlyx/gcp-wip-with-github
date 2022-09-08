
resource "google_compute_instance_template" "default" {
  project = var.project_id
  name         = "test"
  machine_type = "e2-micro"

  tags = ["foo", "bar"]

  disk {
    source_image      = "debian-cloud/debian-11"
    auto_delete       = true
    boot              = true
  }

  disk {
    source      = google_compute_disk.default.name
    auto_delete = false
    boot        = false
  }

  network_interface {
    network = var.network
    access_config {
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"
  }

  resource "google_compute_disk" "default" {
    project = var.project_id
    name  = "test-disk"
    type  = "pd-ssd"
    zone  = var.zone
    image = "debian-11-bullseye-v20220719"
    labels = {
      environment = "dev"
    }
    physical_block_size_bytes = 4096
}

resource "google_compute_instance_from_template" "test_instance" {
  project = var.project_id
  name = "instance-from-template"
  zone = var.zone
  source_instance_template = google_compute_instance_template.default.id
}