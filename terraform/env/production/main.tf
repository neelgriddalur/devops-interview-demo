terraform {
  backend "s3" {
    # backend config will be set by the pipeline
    # this prevents state location from being exposed.
  }
}
provider "aws" {
  region = "us-east-1"
}

module "production" {
  source = "../../module/v1"

  hostname = "oshihealth.production.griddalur.xyz"
}

