data "aws_caller_identity" "current" {}

module "s3_site" {
  source = "./modules/s3-site"

  bucket_name                       = "${local.name_prefix}-${data.aws_caller_identity.current.account_id}"
  tags                              = local.common_tags
  noncurrent_version_retention_days = var.environment == "dev" ? 7 : 14
}

resource "aws_s3_object" "website" {
  for_each = local.website_files

  bucket = module.s3_site.bucket_name
  key    = each.key

  source      = "${path.module}/website/${each.key}"
  source_hash = filemd5("${path.module}/website/${each.key}")

  content_type = each.value
  tags         = local.common_tags
}