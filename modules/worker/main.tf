data "talos_machine_configuration" "worker" {
  cluster_name     = var.cluster_name
  cluster_endpoint = "https://${var.controlplane_loadbalancer_ipv4}:6443"
  machine_type     = "worker"
  machine_secrets  = var.machine_secrets
  config_patches = [
    yamlencode({
      machine = {
        certSANs = ["${var.controlplane_loadbalancer_ipv4}"]
      }
      cluster = {
        network = {
          cni = {
            name = "none"
          }
        }
        proxy = {
          disabled = true
        }
        externalCloudProvider = {
          enabled = true
        }
      }
    })
  ]
  talos_version      = var.talos_version
  kubernetes_version = var.kubernetes_version
}

resource "hcloud_server" "worker" {
  for_each           = var.instances
  name               = each.key
  image              = var.image_id
  server_type        = each.value.server_type
  labels             = { type = "talos-worker" }
  user_data          = data.talos_machine_configuration.worker.machine_configuration
  placement_group_id = var.placement_group_id
  location           = each.value.location
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = var.network_id
    ip         = cidrhost(var.worker_subnet_cidr, index(keys(var.instances), each.key) + 201)
  }
  depends_on = [data.talos_machine_configuration.worker]
}