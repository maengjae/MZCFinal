terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure main AWS provider
provider "aws" {
  region = var.MAIN_REGION
}
