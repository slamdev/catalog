variable "project_id" {
  type = "string"
  description = "GCP project id"
}

variable "name" {
  type = "string"
  description = "Service account name"
}

variable "roles" {
  type = "list"
  description = "List of role for the account"
}
