resource "hcloud_placement_group" "controlplane" {
  name = "controlplane_pg"
  type = "spread"
}

resource "hcloud_placement_group" "worker" {
  name = "worker-pg"
  type = "spread"
}

resource "hcloud_network" "main" {
  name     = var.network_name
  ip_range = var.network_cidr
}

resource "hcloud_network_subnet" "main" {
  network_id   = hcloud_network.main.id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = var.subnet_cidr
}