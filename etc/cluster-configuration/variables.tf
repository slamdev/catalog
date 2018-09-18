variable "gce_credentials" {
  type = "string"
  description = "Path to service account credentials file"
}

variable "project_name" {
  type = "string"
  description = "Project name"
}

variable "region" {
  type = "string"
  description = "GCP region for project"
}

variable "billing_account" {
  type = "string"
  description = "GCP billing account"
}

variable "organization_id" {
  type = "string"
  description = "GCP organization id"
}

variable "dns_name" {
  type = "string"
  description = "DNS name"
}

variable "k8s_username" {
  type = "string"
  description = "Kubernetes master username"
}

variable "k8s_password" {
  type = "string"
  description = "Kubernetes master password"
}
