variable "project_id" {
  type = "string"
  description = "GCP project id"
}

variable "k8s_username" {
  type = "string"
  description = "Kubernetes master username"
}

variable "k8s_password" {
  type = "string"
  description = "Kubernetes master password"
}

variable "region" {
  type = "string"
  description = "GCP region for project"
}
