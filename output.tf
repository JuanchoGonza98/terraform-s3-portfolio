output "bucket_name" {
  description = "Name of the S3 bucket hosting the website assets."
  value       = module.s3_site.bucket_name
}

output "bucket_arn" {
  description = "ARN of the S3 bucket hosting the website assets."
  value       = module.s3_site.bucket_arn
}