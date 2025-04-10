resource "hcloud_load_balancer" "controlplane" {
  name               = "controlplane-lb"
  delete_protection  = true
  load_balancer_type = var.load_balancer_type
  network_zone       = var.network_zone
}

resource "hcloud_load_balancer_network" "controlplane" {
  load_balancer_id = hcloud_load_balancer.controlplane.id
  network_id       = var.network_id
}

resource "hcloud_load_balancer_target" "controlplane" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.controlplane.id
  label_selector   = "type=talos-controlplane"
  use_private_ip   = true
}

# Service pour Kubernetes API (port 6443)
resource "hcloud_load_balancer_service" "kube_api" {
  load_balancer_id = hcloud_load_balancer.controlplane.id
  protocol         = "tcp"
  listen_port      = 6443
  destination_port = 6443
}

# Service pour Talos (port 50000)
resource "hcloud_load_balancer_service" "talos_api" {
  load_balancer_id = hcloud_load_balancer.controlplane.id
  protocol         = "tcp"
  listen_port      = 50000
  destination_port = 50000
}