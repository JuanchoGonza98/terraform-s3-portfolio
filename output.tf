output "bucket_name" {
  description = "Name of the S3 bucket hosting the website assets."
  value       = aws_s3_bucket.site.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket hosting the website assets."
  value       = aws_s3_bucket.site.arn
}