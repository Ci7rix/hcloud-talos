terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.50.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.7.1"
    }
  }
}

# hcloud provider configuration
provider "hcloud" {
  token = var.hcloud_token
}