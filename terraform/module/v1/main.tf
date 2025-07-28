terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.6.0"
    }
  }

  backend "s3" {
    # backend config will be set by the pipeline
    # this prevents state location from being exposed.
  }
}
