terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "talos-hetzner/terraform.tfstate"
    region = "eu-central-1"
    # Uncomment to enable state locking with DynamoDB
    # dynamodb_table = "terraform-locks"
  }
}
