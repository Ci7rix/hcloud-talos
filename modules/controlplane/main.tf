resource "talos_machine_secrets" "this" {
  talos_version = var.talos_version
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
}

data "talos_machine_configuration" "controlplane" {
  cluster_endpoint = "https://${var.controlplane_loadbalancer_ipv4}:6443"
  cluster_name     = var.cluster_name
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  machine_type     = "controlplane"
  depends_on       = [talos_machine_secrets.this]
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

resource "hcloud_server" "controlplane" {
  for_each           = var.instances
  name               = each.key
  image              = var.image_id
  server_type        = var.controlplane_type
  labels             = { type = "talos-controlplane" }
  user_data          = data.talos_machine_configuration.controlplane.machine_configuration
  location           = each.value.location
  rebuild_protection = true
  delete_protection  = true
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = var.network_id
    ip         = cidrhost(var.controlplane_subnet_cidr, index(keys(var.instances), each.key) + 101)
  }
  depends_on = [data.talos_machine_configuration.controlplane]
}

resource "talos_machine_bootstrap" "this" {
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoint             = hcloud_server.controlplane[keys(hcloud_server.controlplane)[0]].ipv4_address
  node                 = hcloud_server.controlplane[keys(hcloud_server.controlplane)[0]].ipv4_address
  depends_on           = [hcloud_server.controlplane]
}

resource "talos_cluster_kubeconfig" "this" {
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoint             = hcloud_server.controlplane[keys(hcloud_server.controlplane)[0]].ipv4_address
  node                 = hcloud_server.controlplane[keys(hcloud_server.controlplane)[0]].ipv4_address
  depends_on           = [talos_machine_bootstrap.this]
}