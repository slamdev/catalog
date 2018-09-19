terraform {
  backend "gcs" {
    // config comes from backend.tfvars
  }
}

provider "google" {
  credentials = "${var.gce_credentials}"
  region = "${var.region}"
  version = "~> 1.16"
}

provider "random" {
  version = "~> 2.0"
}

provider "null" {
  version = "~> 1.0"
}

provider "template" {
  version = "~> 1.0"
}

module "project" {
  source = "./modules/project"
  project_name = "${var.project_name}"
  region = "${var.region}"
  billing_account = "${var.billing_account}"
  organization_id = "${var.organization_id}"
  dns_name = "${var.dns_name}"
}

// https://github.com/terraform-providers/terraform-provider-google/issues/2022
module "gke" {
  source = "./modules/gke"
  project_id = "${module.project.project_id}"
  region = "${var.region}"
  k8s_username = "${var.k8s_username}"
  k8s_password = "${var.k8s_password}"
}

module "gcr_service_account" {
  source = "./modules/service-account"
  project_id = "${module.project.project_id}"
  name = "gcr-sa"
  roles = [
    "roles/storage.admin"
  ]
}
