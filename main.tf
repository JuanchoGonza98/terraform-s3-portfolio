data "aws_caller_identity" "current" {}

module "s3_site" {
  source = "./modules/s3-site"

  bucket_name                       = "${local.name_prefix}-${data.aws_caller_identity.current.account_id}"
  tags                              = local.common_tags
  noncurrent_version_retention_days = var.environment == "dev" ? 7 : 14
  cloudfront_distribution_arn       = aws_cloudfront_distribution.site.arn
}

resource "aws_s3_object" "website" {
  for_each = local.website_files

  bucket = module.s3_site.bucket_name
  key    = each.key

  source      = each.key == "project.json" ? null : "${path.module}/website/${each.key}"
  source_hash = each.key == "project.json" ? null : filemd5("${path.module}/website/${each.key}")

  content_type = each.value
  content = each.key == "project.json" ? templatefile(
    "${path.module}/website/project.json.tftpl",
    {
      environment = var.environment
    }
  ) : null
  tags = local.common_tags
}