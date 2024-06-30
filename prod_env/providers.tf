terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "mjy-bucket"
    key    = "terraform/terraform.tfstate"
    region = "us-east-2"
  }
}

# Configure main AWS provider
provider "aws" {
  region = var.MAIN_REGION
}

provider "aws" {
  alias  = "sub"
  region = var.SUB_REGION
}