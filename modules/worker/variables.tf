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

variable "controlplane_loadbalancer_ipv4" {
  description = "IP du load balancer"
  type        = string
}

variable "network_id" {
  description = "ID du réseau privé"
  type        = string
}

variable "placement_group_id" {
  description = "ID du placement group pour les workers"
  type        = string
}

variable "instances" {
  description = "Configuration détaillée des workers"
  type = map(object({
    server_type = string
    location    = string
  }))
}

variable "machine_secrets" {
  description = "Secrets Talos générés pour le cluster"
  type        = any
}

variable "worker_subnet_cidr" {
  description = "Sous-réseau dédié aux workers"
  type        = string
}