variable "load_balancer_type" {
  description = "Hetzner load balancer size/type (e.g., lb11, lb21)"
  type        = string
}

variable "network_id" {
  description = "ID of the private network where the load balancer will be attached"
  type        = string
}

variable "network_zone" {
  description = "Hetzner network zone for the load balancer (e.g., eu-central)"
  type        = string
}