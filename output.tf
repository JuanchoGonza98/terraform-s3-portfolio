output "bucket_name" {
  description = "Name of the S3 bucket hosting the website assets."
  value       = module.s3_site.bucket_name
}

output "bucket_arn" {
  description = "ARN of the S3 bucket hosting the website assets."
  value       = module.s3_site.bucket_arn
}
output "website_url" {
  description = "Public HTTPS URL of the CloudFront website."
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}