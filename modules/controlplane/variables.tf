variable "cluster_name" {
  description = "Name of the Talos cluster"
  type        = string
}

variable "talos_version" {
  description = "Talos OS version to use for the cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to deploy on the cluster"
  type        = string
}

variable "image_id" {
  description = "OS image ID for the instances (Talos OS image)"
  type        = string
}

variable "controlplane_type" {
  description = "Instance type for control plane nodes"
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

variable "instances" {
  description = "Detailed configuration for control plane instances"
  type = map(object({
    location = string
  }))
}

variable "controlplane_subnet_cidr" {
  description = "Subnet CIDR dedicated to control plane nodes"
  type        = string
}