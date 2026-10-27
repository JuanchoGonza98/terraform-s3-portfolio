data "aws_caller_identity" "current" {}

module "s3_site" {
  source = "./modules/s3-site"

  bucket_name = "${local.name_prefix}-${data.aws_caller_identity.current.account_id}"
  tags        = local.common_tags
}

resource "aws_s3_object" "index" {
  bucket = module.s3_site.bucket_name
  key    = "index.html"

  source      = "${path.module}/website/index.html"
  source_hash = filemd5("${path.module}/website/index.html")

  content_type = "text/html; charset=utf-8"
  tags         = local.common_tags
}