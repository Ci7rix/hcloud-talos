variable "cluster_name" {
  description = "Name of the Talos cluster"
  type        = string
}

variable "talos_version" {
  description = "Talos OS version to use for worker nodes"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to deploy on the worker nodes"
  type        = string
}

variable "image_id" {
  description = "OS image ID for worker instances (Talos OS image)"
  type        = string
}

variable "controlplane_loadbalancer_ipv4" {
  description = "Load balancer IPv4 address for control plane API access"
  type        = string
}

variable "network_id" {
  description = "ID of the private network for cluster communication"
  type        = string
}

variable "placement_group_id" {
  description = "ID of the placement group to distribute worker nodes"
  type        = string
}

variable "instances" {
  description = "Detailed configuration for worker instances including server type and location"
  type = map(object({
    server_type = string
    location    = string
  }))
}

variable "machine_secrets" {
  description = "Talos machine secrets generated for the cluster"
  type        = any
  sensitive   = true
}

variable "worker_subnet_cidr" {
  description = "Subnet CIDR dedicated to worker nodes"
  type        = string
}