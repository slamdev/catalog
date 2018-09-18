output "k8s_host" {
  value = "${google_container_cluster.cluster.endpoint}"
}

output "k8s_username" {
  value = "${google_container_cluster.cluster.master_auth.0.username}"
}

output "k8s_password" {
  value = "${google_container_cluster.cluster.master_auth.0.password}"
}
