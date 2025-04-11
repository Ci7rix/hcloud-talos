# Talos on Hetzner Cloud with Terraform

This project deploys a high-availability Kubernetes cluster using Talos OS on Hetzner Cloud infrastructure.

## Architecture

- 3 control plane nodes distributed across different locations for high availability
- 3 worker nodes distributed across different locations 
- Private network for secure cluster communication
- Load balancer for the Kubernetes API and Talos API endpoints
- Placement groups to ensure nodes are properly distributed

## Prerequisites

- Terraform v1.0+ installed
- A Hetzner Cloud account and API token with read/write permissions
- Talos OS image uploaded to your Hetzner Cloud project

## Usage

1. Clone this repository
2. Create a `terraform.tfvars` file with your configuration (see example below)
3. Run `terraform init` to initialize the project
4. Run `terraform plan` to preview the changes
5. Run `terraform apply` to deploy the infrastructure

### Example terraform.tfvars

```terraform
hcloud_token       = "your_hetzner_cloud_token"
image_id           = "your_talos_image_id"
cluster_name       = "my-talos-cluster"
talos_version      = "v1.9.5"
kubernetes_version = "v1.32.3"
```

## Accessing Your Cluster

After successful deployment, you can retrieve the Talos config and Kubernetes config with:

```bash
terraform output -raw talosconfig > talosconfig
terraform output -raw kubeconfig > kubeconfig

# Configure environment to use these configs
export TALOSCONFIG=$(pwd)/talosconfig
export KUBECONFIG=$(pwd)/kubeconfig
```

## Modules

This project is organized into the following modules:

- **network**: Sets up the private network and placement groups
- **load_balancer**: Configures the load balancer for API access
- **controlplane**: Deploys the Talos control plane nodes
- **worker**: Deploys the Talos worker nodes

## Module Details

### Network Module

Creates a private network, subnets, and placement groups for the cluster.

### Load Balancer Module

Configures a Hetzner Cloud load balancer to distribute traffic to the control plane nodes.

### Control Plane Module

Deploys the Talos control plane nodes across different geographical locations for high availability.

### Worker Module

Deploys the Talos worker nodes that will run your workloads.

## Security Considerations

- All sensitive outputs are marked as sensitive in Terraform
- Control plane nodes have delete and rebuild protection enabled
- Private network is used for internal cluster communication
- Load balancer only exposes necessary Kubernetes and Talos API ports

## Customization

You can customize the deployment by modifying the variables in your `terraform.tfvars` file or by directly editing the module configurations.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
