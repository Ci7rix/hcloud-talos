variable "network_name" {
  description = "Nom du réseau privé"
  type        = string
}

variable "network_cidr" {
  description = "Plage IP principale du réseau"
  type        = string
}

variable "network_zone" {
  description = "Zone réseau Hetzner"
  type        = string
}