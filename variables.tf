variable "network_name" {
  type        = string
  default     = "talos-network"
  description = "Name of the private network used by the Talos cluster"
  
  validation {
    condition     = length(var.network_name) > 3 && length(var.network_name) <= 63
    error_message = "Network name must be between 4 and 63 characters."
  }
}

variable "network_zone" {
  type    = string
  default = "eu-central"
}

variable "network_cidr" {
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
  type        = string
  description = "Hetzner Cloud image ID for Talos OS"
  
  validation {
    condition     = length(var.image_id) > 0
    error_message = "The image_id is required."
  }
}

variable "hcloud_token" {
  type        = string
  description = "Hetzner Cloud API token with read/write permissions"
  sensitive   = true
  
  validation {
    condition     = length(var.hcloud_token) > 20
    error_message = "The hcloud_token should be a valid Hetzner Cloud API token."
  }
}

variable "controlplane_instances" {
  description = "Configuration for control plane instances including location distribution"
  type = map(object({
    location = string
  }))
  default = {
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

variable "worker_instances" {
  description = "Configuration for worker instances including type and location"
  type = map(object({
    server_type = string
    location    = string
  }))
  default = {
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