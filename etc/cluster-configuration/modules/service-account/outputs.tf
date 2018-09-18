output "private_key" {
  value = "${base64decode(google_service_account_key.key.private_key)}"
}
