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
