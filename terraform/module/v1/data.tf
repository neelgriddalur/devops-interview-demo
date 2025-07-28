locals {
  # negative accessors don't work, hack to get the base domain
  parts     = split(".", var.hostname)
  zone_name = join(".", slice(local.parts, length(local.parts) - 2, length(local.parts)))
}
data "aws_route53_zone" "zone" {
  name = local.zone_name
}
