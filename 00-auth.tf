terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.18.0"
    }
  }
}

provider "aws" {
  # Configuration options

  region = "ap-northeast-3"
  profile = "default" # Uses AWS credentials from [default] profile in ~/.aws/credentials

  default_tags {
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

# Terraform backend block sets up configuration to store the state file remotely.
# Bucket can be configured in a different region than the Terraform deployment.
terraform {
  backend "s3" {
    bucket = "kirkdevsecops-terraform-state"
    key = "class7/terraform/dev/kirk-https-web-app-demo/terraform.tfstate"
    region = "us-west-2"
  }
}