output "network_id" {
  value = hcloud_network.main.id
}

output "controlplane_placement_group" {
  value = hcloud_placement_group.controlplane
}

output "worker_placement_group" {
  value = hcloud_placement_group.worker
}