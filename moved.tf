moved {
  from = aws_s3_bucket.site
  to   = module.s3_site.aws_s3_bucket.site
}

moved {
  from = aws_s3_bucket_public_access_block.site
  to   = module.s3_site.aws_s3_bucket_public_access_block.site
}

moved {
  from = aws_s3_bucket_policy.require_https
  to   = module.s3_site.aws_s3_bucket_policy.require_https
}

moved {
  from = aws_s3_bucket_versioning.site
  to   = module.s3_site.aws_s3_bucket_versioning.site
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.site
  to   = module.s3_site.aws_s3_bucket_lifecycle_configuration.site
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.site
  to   = module.s3_site.aws_s3_bucket_server_side_encryption_configuration.site
}