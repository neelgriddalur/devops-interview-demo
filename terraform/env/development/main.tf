provider "aws" {
  region = "us-east-1"
}

module "development" {
  source = "../../module/v1"

  hostname = "oshihealth.development.griddalur.xyz"
}

