resource "google_container_cluster" "cluster" {
  name = "gke-cluster"
  zone = "${data.google_compute_zones.zones.names[0]}"
  project = "${var.project_id}"
  min_master_version = "${data.google_container_engine_versions.k8s_version.latest_master_version}"
  remove_default_node_pool = true
  logging_service = "none"
  monitoring_service = "none"

  node_pool {
    name = "default-pool"
  }

  lifecycle {
    ignore_changes = [
      "node_pool"
    ]
  }

  master_auth {
    username = "${var.k8s_username}"
    password = "${var.k8s_password}"
  }
}

resource "google_container_node_pool" "pool" {
  name = "primary-pool"
  cluster = "${google_container_cluster.cluster.name}"
  zone = "${data.google_compute_zones.zones.names[0]}"
  project = "${var.project_id}"
  initial_node_count = 3

  autoscaling {
    min_node_count = 3
    max_node_count = 6
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "f1-micro"
    disk_size_gb = 10
    preemptible = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

data "google_compute_zones" "zones" {
  project = "${var.project_id}"
  region = "${var.region}"
  status = "UP"
}

data "google_container_engine_versions" "k8s_version" {
  project = "${var.project_id}"
  zone = "${data.google_compute_zones.zones.names[0]}"
}
