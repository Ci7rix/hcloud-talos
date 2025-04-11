variable "cluster_name" {
  description = "Nom du cluster Talos"
  type        = string
}

variable "talos_version" {
  description = "Version Talos"
  type        = string
}

variable "kubernetes_version" {
  description = "Version Kubernetes"
  type        = string
}

variable "image_id" {
  description = "Image OS pour les instances"
  type        = string
}

variable "controlplane_type" {
  description = "Type d'instance pour les control planes"
  type        = string
}

variable "controlplane_loadbalancer_ipv4" {
  description = "IP du load balancer"
  type        = string
}

variable "network_id" {
  description = "ID du réseau privé"
  type        = string
}

variable "instances" {
  description = "Configuration détaillée des instances control plane"
  type = map(object({
    location = string
  }))
}

variable "controlplane_network_cidr" {
  description = "Sous-réseau dédié aux control planes"
  type        = string
}