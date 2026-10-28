output "bucket_name" {
  description = "Name of the S3 bucket."
  value       = aws_s3_bucket.site.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket."
  value       = aws_s3_bucket.site.arn
}
output "bucket_regional_domain_name" {
  description = "Regional S3 endpoint used as the CloudFront origin."
  value       = aws_s3_bucket.site.bucket_regional_domain_name
}