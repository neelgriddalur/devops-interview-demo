provider "aws" {
  region = "us-east-1"
}

module "production" {
  source = "../../module/v1"

  hostname = "oshi.production.griddalur.xyz"
}

