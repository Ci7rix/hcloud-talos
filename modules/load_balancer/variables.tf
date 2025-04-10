variable "load_balancer_type" {
  description = "Type de load balancer Hetzner"
  type        = string
}

variable "network_id" {
  description = "ID du réseau privé associé"
  type        = string
}

variable "network_zone" {
  description = "Zone réseau Hetzner"
  type        = string
}