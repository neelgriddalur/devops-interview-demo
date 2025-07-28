resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = "S3-Bucket-${aws_s3_bucket.bucket.id}"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = compact([var.hostname])

  default_cache_behavior {
    target_origin_id = "S3-Bucket-${aws_s3_bucket.bucket.id}"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = true
      headers      = ["Origin"]
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.validation.certificate_arn
    ssl_support_method  = "sni-only"
  }

  wait_for_deployment = true
  depends_on = [
    aws_s3_bucket.bucket,
    aws_acm_certificate_validation.validation,
  ]
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "cf-access-identity-${aws_s3_bucket.bucket.id}"
}
