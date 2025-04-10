variable "network_name" {
  type    = string
  default = "talos-network"
}

variable "network_zone" {
  type    = string
  default = "eu-central"
}

variable "network_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "load_balancer_type" {
  type    = string
  default = "lb11"
}

variable "cluster_name" {
  type    = string
  default = "hcloud-talos"
}

variable "talos_version" {
  type    = string
  default = "v1.9.5"
}

variable "kubernetes_version" {
  type    = string
  default = "v1.32.3"
}

variable "controlplane_type" {
  type    = string
  default = "cax11"
}

variable "image_id" {
  type = string
}