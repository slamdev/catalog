resource "google_project" "project" {
  name = "${var.project_name}"
  project_id = "${random_id.id.hex}"
  billing_account = "${var.billing_account}"
  org_id = "${var.organization_id}"
}

resource "google_project_services" "services" {
  project = "${google_project.project.project_id}"
  services = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "dns.googleapis.com",
    "oslogin.googleapis.com",
    "replicapool.googleapis.com",
    "replicapoolupdater.googleapis.com",
    "resourceviews.googleapis.com",
    "servicemanagement.googleapis.com",
    "bigquery-json.googleapis.com",
    "pubsub.googleapis.com",
    "deploymentmanager.googleapis.com",
    "storage-api.googleapis.com"
  ]
}

resource "google_dns_managed_zone" "zone" {
  depends_on = [
    "google_project_services.services"
  ]
  project = "${google_project.project.project_id}"
  name = "dns-zone"
  description = "DNS Zone"
  dns_name = "${var.dns_name}"
}

resource "random_id" "id" {
  byte_length = 4
  prefix = "${var.project_name}-"
}
