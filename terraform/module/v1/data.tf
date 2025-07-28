data "aws_route53_zone" "zone" {
  name = split(".", var.hostname)[-2] + "." + split(".", var.hostname)[-1]
}
