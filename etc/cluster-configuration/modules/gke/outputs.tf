output "k8s_host" {
  value = "${google_container_cluster.cluster.endpoint}"
}

output "gke_node_pool_cluster" {
  value = "${google_container_node_pool.pool.cluster}"
}
