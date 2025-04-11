module "network" {
  source = "./modules/network"

  network_name = var.network_name
  network_zone = var.network_zone
  network_cidr = var.network_cidr
}

module "load_balancer" {
  source = "./modules/load_balancer"

  load_balancer_type = var.load_balancer_type
  network_id         = module.network.network_id
  network_zone       = var.network_zone
}

module "controlplane" {
  source = "./modules/controlplane"

  network_id                     = module.network.network_id
  cluster_name                   = var.cluster_name
  talos_version                  = var.talos_version
  kubernetes_version             = var.kubernetes_version
  image_id                       = var.image_id
  controlplane_loadbalancer_ipv4 = module.load_balancer.controlplane_loadbalancer_ipv4
  controlplane_type              = var.controlplane_type
  controlplane_subnet_cidr       = var.network_cidr

  instances = {
    "controlplane-1" = {
      location = "nbg1"
    }
    "controlplane-2" = {
      location = "hel1"
    }
    "controlplane-3" = {
      location = "fsn1"
    }
  }
}

module "worker" {
  source = "./modules/worker"

  cluster_name                   = var.cluster_name
  controlplane_loadbalancer_ipv4 = module.load_balancer.controlplane_loadbalancer_ipv4
  placement_group_id             = module.network.worker_placement_group.id
  machine_secrets                = module.controlplane.machine_secrets
  talos_version                  = var.talos_version
  kubernetes_version             = var.kubernetes_version
  image_id                       = var.image_id
  network_id                     = module.network.network_id
  worker_subnet_cidr             = var.network_cidr
  instances = {
    "worker-1" = {
      server_type = "cax21"
      location    = "nbg1"
    }
    "worker-2" = {
      server_type = "cax21"
      location    = "fsn1"
    }
    "worker-3" = {
      server_type = "cax21"
      location    = "hel1"
    }
  }
}