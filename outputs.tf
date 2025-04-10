output "talosconfig" {
  value     = module.controlplane.talosconfig
  sensitive = true
}

output "kubeconfig" {
  value     = module.controlplane.kubeconfig
  sensitive = true
}