variable "network_name" {
  description = "Name of the private network used by the Talos cluster"
  type        = string
}

variable "network_cidr" {
  description = "Main IP range for the private network (e.g., 10.0.0.0/24)"
  type        = string
}

variable "network_zone" {
  description = "Hetzner network zone for deployment (e.g., eu-central)"
  type        = string
}